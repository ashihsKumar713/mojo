// Copyright 2013 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This example program is based on Simple_VertexShader.c from:

//
// Book:      OpenGL(R) ES 2.0 Programming Guide
// Authors:   Aaftab Munshi, Dan Ginsburg, Dave Shreiner
// ISBN-10:   0321502795
// ISBN-13:   9780321502797
// Publisher: Addison-Wesley Professional
// URLs:      http://safari.informit.com/9780321563835
//            http://www.opengles-book.com
//

#include "examples/spinning_cube/gl_util.h"

#include <GLES2/gl2.h>

#include "mojo/public/cpp/environment/logging.h"

namespace examples {

GLuint LoadShader(GLenum type, const char* shader_source) {
  GLuint shader = glCreateShader(type);
  glShaderSource(shader, 1, &shader_source, NULL);
  glCompileShader(shader);

  GLint compiled = 0;
  glGetShaderiv(shader, GL_COMPILE_STATUS, &compiled);

  if (!compiled) {
    GLsizei expected_length = 0;
    glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &expected_length);
    std::string log;
    log.resize(expected_length);  // Includes null terminator.
    GLsizei actual_length = 0;
    glGetShaderInfoLog(shader, expected_length, &actual_length, &log[0]);
    log.resize(actual_length);  // Excludes null terminator.
    MOJO_LOG(FATAL) << "Compilation of shader failed: " << log;
    glDeleteShader(shader);
    return 0;
  }

  return shader;
}

GLuint LoadProgram(const char* vertex_shader_source,
                   const char* fragment_shader_source) {
  GLuint vertex_shader = LoadShader(GL_VERTEX_SHADER, vertex_shader_source);
  if (!vertex_shader)
    return 0;

  GLuint fragment_shader =
      LoadShader(GL_FRAGMENT_SHADER, fragment_shader_source);
  if (!fragment_shader) {
    glDeleteShader(vertex_shader);
    return 0;
  }

  GLuint program_object = glCreateProgram();
  glAttachShader(program_object, vertex_shader);
  glAttachShader(program_object, fragment_shader);
  glLinkProgram(program_object);
  glDeleteShader(vertex_shader);
  glDeleteShader(fragment_shader);

  GLint linked = 0;
  glGetProgramiv(program_object, GL_LINK_STATUS, &linked);
  if (!linked) {
    GLsizei expected_length = 0;
    glGetProgramiv(program_object, GL_INFO_LOG_LENGTH, &expected_length);
    std::string log;
    log.resize(expected_length);  // Includes null terminator.
    GLsizei actual_length = 0;
    glGetProgramInfoLog(program_object, expected_length, &actual_length,
                        &log[0]);
    log.resize(actual_length);  // Excludes null terminator.
    MOJO_LOG(FATAL) << "Linking program failed: " << log;
    glDeleteProgram(program_object);
    return 0;
  }

  return program_object;
}

}  // namespace examples
