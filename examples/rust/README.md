# Sample Rust Mojo Applications

This directory contains sample Mojo applications written in Rust. These are
more general applications which may not cover every use-case of the bindings.

[TOC]

## Applications

*   system_echo
    *   A basic Rust application which uses message pipes to implement an
        echo server and client across threads.

## Setup Instructions

Prior to setting up these examples, you must have run either `fetch mojo` or
`gclient sync` to have pulled a Rust as a dependency. Instructions for building
Mojo can be found in the root source directory at README.md.

1.  For all examples, run the following from the root source directory to
    build:

```bash
mojo/tools/mojob.py gn
mojo/tools/mojob.py build
```

2.  To execute the example, run the following, substituting the example's
    name.

```bash
mojo/devtools/common/mojo_run mojo:rust_<example name here>
```

