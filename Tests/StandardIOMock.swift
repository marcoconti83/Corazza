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
import XCTest
@testable import Corazza

/// This class mocks the interaction with stdin and stdout
/// and allows to retrive strings that were read and written
class IOMock {
    
    /// Input to feed on stdin
    private var stdinQueue = [String]()
    
    /// Output read on stdout
    private var stdoutQueue = [String]()
    
    /// Adds a line to feed to stdin when asked
    func addInput(line: String) {
        stdinQueue.append(line)
    }
    
    /// Whether it still has more input to feed to stdin
    var hasMoreInput : Bool {
        return stdinQueue.count > 0
    }
    
    /// Wheter it still has more output to pop
    var hasMoreOutput : Bool {
        return stdoutQueue.count > 0
    }
    
    /// Pops one line read on stdout
    func popOutput() -> String? {
        if stdoutQueue.count > 0 {
            return stdoutQueue.removeFirst()
        } else {
            return nil
        }
    }
    
    /// Output recorded so far on stdout
    var currentOutput : [String] {
        return stdoutQueue
    }
}

extension IOMock {
    
    func printMock(items: [Any], separator: String = " ", terminator: String = "\n") -> Void {
        let text = items.map { return "\($0)" }.joinWithSeparator(separator) + terminator
        stdoutQueue.append(text)
    }
    
    func readlineMock(stripNewline: Bool = false) -> String? {
        guard stdinQueue.count > 0 else { return nil }
        let text = stdinQueue.removeFirst()
        if stripNewline && text.hasSuffix("\n") {
            return text.substringToIndex(text.endIndex.predecessor().predecessor())
        }
        return text
    }
}

/// Base class for all tests that need to test interaction with
/// stdin and stdout. Provides a `mockIO` variable to mock/monitor
/// both.
class CorazzaTest : XCTestCase {
    
    var mockIO : IOMock! = nil
    
    override func setUp() {
        super.setUp()
        self.mockIO = IOMock()
        
        TestablePrintFunction = { (items: [Any], separator: String, terminator: String) -> Void in
            self.mockIO.printMock(items, separator: separator, terminator: terminator)
        }
        TestableReadLineFunction = { (stripNewLine: Bool) -> String? in
            return self.mockIO.readlineMock(stripNewLine)
        }
    }
    
    override func tearDown() {
        TestableReadLineFunction = nil
        TestablePrintFunction = nil
        self.mockIO = nil
        super.tearDown()
    }
}