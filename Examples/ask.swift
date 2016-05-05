#!/usr/bin/swift -F Carthage/Build/Mac
// Copyright (c) 2015  Marco Conti
//
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
//
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
//
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


// INSTRUCTIONS: 
// before running this script, make sure to run
//      carthage build --no-skip-current
// from the project folder. Then you can invoke it **from the project folder** using
//  ./Examples/ask.swift
//

import Corazza

let prompt = Prompt()
guard prompt.yesNo("Do you like turtles?", defaultAnswer: true) else { exit(0) }

let turtles = [
    "Chelonoidis nigra",
    "Dermochelys coriacea",
    "Chelydra serpentina",
    "Trachemys scripta elegans"
]

let favourite = prompt.options(turtles, question: "Which one is your favourite?")!
print("I love \(favourite)!")


