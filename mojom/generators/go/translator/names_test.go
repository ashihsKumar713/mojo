// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package translator

import (
	"testing"
)

func TestFormatName(t *testing.T) {
	testCases := []struct {
		expected string
		name     string
	}{
		{"Hello", "hello"},
		{"Hello", "Hello"},
		{"HelloWorld", "HelloWorld"},
		{"HelloWorld", "hello_world"},
		{"HttpWorld", "HTTPWorld"},
		{"HttpWorld", "HTTP_World"},
	}

	for _, testCase := range testCases {
		checkEq(t, testCase.expected, formatName(testCase.name))
	}
}

func TestPrivateName(t *testing.T) {
	testCases := []struct {
		expected string
		public   string
	}{
		{"hello", "hello"},
		{"hello", "Hello"},
	}

	for _, testCase := range testCases {
		checkEq(t, testCase.expected, privateName(testCase.public))
	}
}
