//Copyright (c) Marco Conti 2016
//
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

import Foundation

typealias PrintFunction = ([Any], _ separator: String, _ terminator: String) -> Void
typealias ReadLineFunction = (_ stripNewLine: Bool) -> String?

/// Overridable print function for test
var TestablePrintFunction : PrintFunction? = nil

/// Overridable read line function for tests
var TestableReadLineFunction : ReadLineFunction? = nil

/// Prints using the standard print function, or the override if set
func customPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    if let override = TestablePrintFunction {
        override(items, separator, terminator)
    } else {
        let itemsString = items.map { String(describing: $0) }.joined(separator: " ")
        print(itemsString, separator: separator, terminator: terminator)
    }
}

/// Prints using the standard print function, or the override if set
func customReadline(_ stripNewLine: Bool = false) -> String? {
    let standard : ReadLineFunction = readLine(strippingNewline:)
    let override = TestableReadLineFunction != nil ? TestableReadLineFunction! : standard
    return override(stripNewLine)
}
