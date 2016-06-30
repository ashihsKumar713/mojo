# Echo Client & Server using System Module

This samples uses the low-level Rust Mojo bindings which wrap the C API and
do not utilize Mojom interfaces in order to implement an echo client and
server which operates across threads.

## Setup Instructions

Prior to setting up these examples, you must have run either `fetch mojo` or
`gclient sync` to have pulled a Rust as a dependency. Instructions for building
Mojo can be found in the root source directory at README.md.

1.  From the root src directory run:

```bash
mojo/tools/mojob.py gn
mojo/tools/mojob.py build
```

2.  Then run:

```bash
mojo/devtools/common/mojo_run mojo:rust_system_echo
```

## Cargo Build Instructions

1.  First, set the Mojo output directory in order for Cargo to be able to find
    the Mojo dependencies:

```bash
export MOJO_OUT_DIR=/path/to/out/Debug
```

2.  Build normally using Cargo:

```bash
cargo build
```

Additional non-standard environment variables that Cargo will respond to:
*   MOJO_RUST_NO_EMBED - Specifies to not bundle the Mojo embedder or link
    against libstdc++, which is recommended for examples as they are Mojo
    applications.

3.  Then to run, one needs to invoke a mojo shell:

```bash
../../../mojo/devtools/common/mojo_run target/debug/libsystem_echo.so
```

The reason for the strange naming convention here is that cargo needs to build
this as a dynamic library, and this is the default behavior which cannot be
changed easily as of right now.
