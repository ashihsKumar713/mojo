// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// This macro provides a common implementation of MojomEncodable
/// for MojomPointer types.
///
/// Note: it does not implement compute_size();
///
/// The Rust type system currently lacks the facilities to do this
/// generically (need mutually excludable traits) but this macro
/// should be replaced as soon as this is possible.
#[macro_export]
macro_rules! impl_encodable_for_pointer {
    () => {
        fn mojom_alignment() -> usize {
            8 // All mojom pointers are 8 bytes in length, and thus are 8-byte aligned
        }
        fn mojom_type() -> $crate::bindings::mojom::MojomType {
            $crate::bindings::mojom::MojomType::Pointer
        }
        fn embed_size(_context: &$crate::bindings::encoding::Context) -> $crate::bindings::encoding::Bits {
            $crate::bindings::mojom::POINTER_BIT_SIZE
        }
        fn encode(self, encoder: &mut $crate::bindings::encoding::Encoder, context: $crate::bindings::encoding::Context) {
            let loc = encoder.size() as u64;
            {
                let state = encoder.get_mut(&context);
                state.encode_pointer(loc);
            }
            self.encode_new(encoder, context);
        }
    };
}

/// This macro provides a common implementation of MojomEncodable
/// for MojomUnion types.
///
/// Note: it does not implement compute_size();
///
/// The Rust type system currently lacks the facilities to do this
/// generically (need mutually excludable traits) but this macro
/// should be replaced as soon as this is possible.
#[macro_export]
macro_rules! impl_encodable_for_union {
    () => {
        fn mojom_alignment() -> usize {
            8
        }
        fn mojom_type() -> $crate::bindings::mojom::MojomType {
            $crate::bindings::mojom::MojomType::Union
        }
        fn embed_size(context: &$crate::bindings::encoding::Context) -> $crate::bindings::encoding::Bits {
            if context.is_union() {
                Self::nested_embed_size()
            } else {
                Self::inline_embed_size()
            }
        }
        fn encode(self, encoder: &mut $crate::bindings::encoding::Encoder, context: $crate::bindings::encoding::Context) {
            if context.is_union() {
                self.nested_encode(encoder, context);
            } else {
                self.inline_encode(encoder, context.set_is_union(true));
            }
        }
    }
}

/// This macro provides a common implementation of MojomEncodable
/// for MojomInterface types.
///
/// Note: it does not implement compute_size();
///
/// The Rust type system currently lacks the facilities to do this
/// generically (need mutually excludable traits) but this macro
/// should be replaced as soon as this is possible.
#[macro_export]
macro_rules! impl_encodable_for_interface {
    () => {
        fn mojom_alignment() -> usize {
            4
        }
        fn mojom_type() -> $crate::bindings::mojom::MojomType {
            $crate::bindings::mojom::MojomType::Interface
        }
        fn embed_size(_context: &$crate::bindings::encoding::Context) -> $crate::bindings::encoding::Bits {
            use std::mem;
            $crate::bindings::encoding::Bits(2 * 8 * mem::size_of::<u32>())
        }
        fn compute_size(&self, _context: $crate::bindings::encoding::Context) -> usize {
            0 // Indicates that this type is inlined and it adds nothing external to the size
        }
        fn encode(self, encoder: &mut $crate::bindings::encoding::Encoder, context: $crate::bindings::encoding::Context) {
            let pos = encoder.add_handle(self.as_untyped());
            let mut state = encoder.get_mut(&context);
            state.encode(pos as i32);
            state.encode(Self::version() as u32);
        }
    }
}
