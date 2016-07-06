// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef EXAMPLES_SPINNING_CUBE_GL_UTIL_H_
#define EXAMPLES_SPINNING_CUBE_GL_UTIL_H_

#include <GLES2/gl2.h>

namespace examples {

GLuint LoadShader(GLenum type, const char* shader_source);

GLuint LoadProgram(const char* vertex_shader_source,
                   const char* fragment_shader_source);

}  // namespace examples

#endif  // EXAMPLES_SPINNING_CUBE_GL_UTIL_H_
