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

import XCTest
@testable import Corazza

let standardYesNoPrompt = Prompt.yesOrNoPrompt + " > "
let standardNoPropmt = Prompt.yesOrNoPrompt + " (default: N) > "
let standardYesPropmt = Prompt.yesOrNoPrompt + " (default: Y) > "
let notAValidAnswer = Prompt.notValidAnswer + "\n"

class PromptTests: CorazzaTest {
}

// MARK: - Yes and no
extension PromptTests {
    
    func testThatItAsksYesNo_YesAnswer() {
        
        for answer in ["Y", "y", "yes", "Yes", "YES"] {
            // given
            self.mockIO.addInput(answer)
            
            //when
            let result = Prompt().yesNo()
            
            // then
            XCTAssertTrue(result, "Wrong result for \(answer)")
            XCTAssertEqual(self.mockIO.popOutput(), standardYesNoPrompt)
        }
        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }

    func testThatItAsksYesNo_NoAnswer() {
        
        for answer in ["N", "n", "no", "No", "NO"] {
            // given
            self.mockIO.addInput(answer)
            
            //when
            let result = Prompt().yesNo()
            
            // then
            XCTAssertFalse(result, "Wrong result for \(answer)")
            XCTAssertEqual(self.mockIO.popOutput(), standardYesNoPrompt)
        }
        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }
    
    func testThatItAsksYesNo_YesAnswer_DefaultYes() {
        
        for answer in ["Y", "y", "yes", "Yes", "YES"] {
            // given
            self.mockIO.addInput(answer)
            
            //when
            let result = Prompt().yesNo(defaultAnswer: true)
            
            // then
            XCTAssertTrue(result, "Wrong result for \(answer)")
            XCTAssertEqual(self.mockIO.popOutput(), standardYesPropmt)
        }
        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }

    func testThatItAsksYesNo_YesAnswer_DefaultNo() {
        
        for answer in ["Y", "y", "yes", "Yes", "YES"] {
            // given
            self.mockIO.addInput(answer)
            
            //when
            let result = Prompt().yesNo(defaultAnswer: false)
            
            // then
            XCTAssertTrue(result, "Wrong result for \(answer)")
            XCTAssertEqual(self.mockIO.popOutput(), standardNoPropmt)
        }
        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }
    
    func testThatItAsksYesNo_NoAnswer_DefaultYes() {
        
        for answer in ["N", "n", "no", "No", "NO"] {
            // given
            self.mockIO.addInput(answer)
            
            //when
            let result = Prompt().yesNo(defaultAnswer: true)
            
            // then
            XCTAssertFalse(result, "Wrong result for \(answer)")
            XCTAssertEqual(self.mockIO.popOutput(), standardYesPropmt)
        }
        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }
    
    func testThatItAsksYesNo_NoAnswer_DefaultNo() {
        
        for answer in ["N", "n", "no", "No", "NO"] {
            // given
            self.mockIO.addInput(answer)
            
            //when
            let result = Prompt().yesNo(defaultAnswer: false)
            
            // then
            XCTAssertFalse(result, "Wrong result for \(answer)")
            XCTAssertEqual(self.mockIO.popOutput(), standardNoPropmt)
        }
        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }
    
    func testThatItAsksYesNo_DefaultAnswerYes() {
        
        // given
        self.mockIO.addInput("")
        
        //when
        let result = Prompt().yesNo(defaultAnswer: true)
        
        // then
        XCTAssertTrue(result)
        XCTAssertEqual(self.mockIO.popOutput(), standardYesPropmt)
        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }
    
    func testThatItAsksYesNo_DefaultAnswerNo() {
        
        // given
        self.mockIO.addInput("")
        
        //when
        let result = Prompt().yesNo(defaultAnswer: false)
        
        // then
        XCTAssertFalse(result)
        XCTAssertEqual(self.mockIO.popOutput(), standardNoPropmt)
        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }
    
    func testThatItKeepsAskingUntilTheAnswerIsValid() {
        
        // given
        self.mockIO.addInput("a")
        self.mockIO.addInput("")
        self.mockIO.addInput("bla bla bla bla")
        self.mockIO.addInput("y")
        
        //when
        let result = Prompt().yesNo()
        
        // then
        XCTAssertTrue(result)
        // 3 wrong
        for _ in 0..<3 {
            XCTAssertEqual(self.mockIO.popOutput(), standardYesNoPrompt)
            XCTAssertEqual(self.mockIO.popOutput(), notAValidAnswer)
        }
        // 1 correct
        XCTAssertEqual(self.mockIO.popOutput(), standardYesNoPrompt)

        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }
    
    func testThatItAsksWithCustomQuestion() {
        
        // given
        let question = "Answer me!"
        self.mockIO.addInput("y")
        
        // when
        let result = Prompt().yesNo(question)
        
        // then
        XCTAssertTrue(result)
        XCTAssertEqual(self.mockIO.popOutput(), question+"\n")
        XCTAssertEqual(self.mockIO.popOutput(), standardYesNoPrompt)
    
        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }
}

// MARK: - Options
extension PromptTests {
    
    func testThatItAsksAnOptionByIndex() {
        
        // given
        let options = ["a", "b", "c", "d"]
        self.mockIO.addInput("2")
        
        // when
        let result = Prompt().options(options)
        
        // then
        XCTAssertEqual(result, "b")
        XCTAssertEqual(self.mockIO.popOutput(), Prompt.optionsSeparator+"\n")
        for i in 1...options.count {
            XCTAssertEqual(self.mockIO.popOutput(), "\(i)\t\(options[i-1])\n")
        }
        XCTAssertEqual(self.mockIO.popOutput(), Prompt.optionsSeparator+"\n")
        XCTAssertEqual(self.mockIO.popOutput(), Prompt.choosePrompt+" > ")
        
        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }
    
    func testThatItAsksAnOptionByIndexUntilItGetsAValidIndex() {
        
        // given
        let options = ["a", "b", "c", "d"]
        let answers = [
            "0", // zero
            "-1", // negative
            "10", // too big
            "aa", // not a number
            "", // empty
            "2 a", // not a number
            "2.2", // not an int
            "2 2", // not a number
            "3" // VALID
        ]
        answers.forEach { self.mockIO.addInput($0) }
        
        // when
        let result = Prompt().options(options)
        
        // then
        XCTAssertEqual(result, "c")
        for i in 0..<answers.count {
            if i > 0 {
                XCTAssertEqual(self.mockIO.popOutput(), Prompt.notValidAnswer + "\n")
                XCTAssertEqual(self.mockIO.popOutput(), "\n")
            }
            XCTAssertEqual(self.mockIO.popOutput(), Prompt.optionsSeparator+"\n")
            for i in 1...options.count {
                XCTAssertEqual(self.mockIO.popOutput(), "\(i)\t\(options[i-1])\n")
            }
            XCTAssertEqual(self.mockIO.popOutput(), Prompt.optionsSeparator+"\n")
            XCTAssertEqual(self.mockIO.popOutput(), Prompt.choosePrompt+" > ")
        }
        
        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }
    
    func testThatItAsksAnOptionByIndexWithDefault() {
        
        // given
        let options = ["a", "b", "c", "d"]
        let defaultAnswer = "c"
        self.mockIO.addInput("")
        
        // when
        let result = Prompt().options(options, defaultAnswer: defaultAnswer)
        
        // then
        XCTAssertEqual(result, defaultAnswer)
        
        XCTAssertEqual(self.mockIO.popOutput(), Prompt.optionsSeparator+"\n")
        for i in 1...options.count {
            XCTAssertEqual(self.mockIO.popOutput(), "\(i)\t\(options[i-1])\n")
        }
        XCTAssertEqual(self.mockIO.popOutput(), Prompt.optionsSeparator+"\n")
        let defaultText = " (default: \(defaultAnswer))"
        XCTAssertEqual(self.mockIO.popOutput(), Prompt.choosePrompt + defaultText + " > ")
        
        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }
    
    func testThatItAsksAnOptionByIndexWithCustomQuestion() {
        
        // given
        let options = ["a", "b", "c", "d"]
        let question = "Which one do you like?"
        self.mockIO.addInput("2")
        
        // when
        let result = Prompt().options(options, question: question)
        
        // then
        XCTAssertEqual(result, "b")
        XCTAssertEqual(self.mockIO.popOutput(), question+"\n")
        XCTAssertEqual(self.mockIO.popOutput(), Prompt.optionsSeparator+"\n")
        for i in 1...options.count {
            XCTAssertEqual(self.mockIO.popOutput(), "\(i)\t\(options[i-1])\n")
        }
        XCTAssertEqual(self.mockIO.popOutput(), Prompt.optionsSeparator+"\n")
        XCTAssertEqual(self.mockIO.popOutput(), Prompt.choosePrompt+" > ")
        
        XCTAssertFalse(self.mockIO.hasMoreInput)
        XCTAssertFalse(self.mockIO.hasMoreOutput)
    }
}
