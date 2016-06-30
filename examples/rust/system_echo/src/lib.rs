// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This example demonstrates a slightly more practical use case of message
// pipes.

#[macro_use]
extern crate mojo;

use mojo::system::message_pipe;

use std::io;
use std::io::Write;
use std::thread;
use std::string::String;
use std::vec::Vec;

// This macro should be used before the first functional code section but
// after any imports. Although not strictly necessary, stylistically this
// works out the best since we specify in a noticable location what the
// true entry point of the program is.
set_mojo_main!(mojo_main);

fn mojo_main(_handle: message_pipe::MessageEndpoint) -> mojo::MojoResult {
    // Create the message pipe
    let (c_end, s_end) = message_pipe::create(mpflags!(Create::None)).unwrap();

    println!("Send a message! It'll be echoed back to you.");
    println!("Even unicode characters work! ( ﾟヮﾟ)");
    println!("Enter 'quit' to exit.");

    let server = thread::spawn(move || server_loop(s_end));
    let client = thread::spawn(move || client_loop(c_end));

    let _rc = client.join();
    let _sc = server.join();

    mojo::MojoResult::Okay
}

fn write_msg(endpt: &message_pipe::MessageEndpoint, msg: &String) {
    let msg_bytes = msg.clone().into_bytes();
    let result = endpt.write(&msg_bytes, Vec::new(), mpflags!(Write::None));
    if result != mojo::MojoResult::Okay {
        panic!("Failed to write! Error: {}", result);
    }
}

fn read_msg(endpt: &message_pipe::MessageEndpoint) -> Option<String> {
    match endpt.read(mpflags!(Read::None)) {
        Ok((msg, _)) => Some(String::from_utf8(msg).unwrap()),
        Err(r) => {
            match r {
                mojo::MojoResult::Okay => Some("".to_string()),
                mojo::MojoResult::ShouldWait => None,
                _ => panic!("Failed to read! Error: {}", r),
            }
        }
    }
}

fn client_loop(endpt: message_pipe::MessageEndpoint) {
    'input: loop {
        print!("> ");
        io::stdout().flush().unwrap();
        let mut line = String::new();
        match io::stdin().read_line(&mut line) {
            Ok(_) => {
                let len = line.len();
                line.truncate(len - 1);
                println!("Send: {}", line);
                write_msg(&endpt, &line);
                if line == "quit".to_string() {
                    break 'input;
                }
            }
            Err(err) => {
                println!("You messed up, try again. This was the cause: {}", err);
            }
        }
        'read: loop {
            match read_msg(&endpt) {
                Some(s) => {
                    println!("Recv: {}", s);
                    break 'read;
                }
                None => (),
            }
        }
    }
}

fn server_loop(endpt: message_pipe::MessageEndpoint) {
    'serve: loop {
        match read_msg(&endpt) {
            Some(s) => {
                if s == "quit".to_string() {
                    break 'serve;
                }
                write_msg(&endpt, &s);
            }
            None => (),
        }
    }
}
