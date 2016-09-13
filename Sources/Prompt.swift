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

public class Prompt {

    /// Inputs that represent no/false
    static let noSynonyms = Set(["no", "n"])
    
    /// Inputs that represent yes/trye
    static let yesSynonyms = Set(["yes", "y"])
    
    /// Text to print when it reads an invalid answer
    static let notValidAnswer = "Not a valid answer"
    
    /// Prompt for yes/no
    static let yesOrNoPrompt = "[Y]es or [N]o?"
    
    /// Prompt for choosing an option
    static let choosePrompt = "Choose an option"
    
    /// Separator for options
    static let optionsSeparator = "------------------------------------"
    
    public init() {}
    
    /// Prints a question on standard output, then reads an aswer from standard input.
    /// It will keep asking until it reads a valid answer.
    /// - parameter defaultAnswer: if not nil and no answer is read (empty line), it will return this
    public func ask(_ question: String? = nil, defaultAnswer: String? = nil) -> String {
        
        // default?
        let defaultText = { Void -> String in
            guard let defaultAnswer = defaultAnswer else { return "" }
            return " (default: \(defaultAnswer))"
        }()

        while true {
            
            // question
            if let question = question {
                customPrint(question)
            }
            
            // print prompt
            customPrint(defaultText, terminator: " > ")
            
            // parse answer
            guard let answer = customReadline(true)?.trim else {
                fatalError("EOF?")
            }
            if answer == "" {
                if let defaultAnswer = defaultAnswer {
                    return defaultAnswer
                }
                continue
            }
            return answer
        }
    }
    
    /// Prints a question on standard output, then reads a Yes/No answer
    /// from standard input. It keeps reading until it reads a valid answer
    /// - returns: true if it read a Yes, false if it read a No
    public func yesNo(_ question: String? = nil, defaultAnswer: Bool? = nil) -> Bool {
        
        // question
        if let question = question {
            customPrint(question)
        }
        
        // default?
        let defaultText = { Void -> String in
            guard let defaultAnswer = defaultAnswer else { return "" }
            let mapping = [true: "Y", false: "N"]
            return " (default: \(mapping[defaultAnswer]!))"
        }()
        
        while true {
            
            // print prompt
            customPrint(Prompt.yesOrNoPrompt + defaultText, terminator: " > ")
            
            // parse answer
            guard let answer = customReadline(true)?.trim.lowercased() else {
                fatalError("EOF?")
            }
            if Prompt.noSynonyms.contains(answer) {
                return false
            }
            if Prompt.yesSynonyms.contains(answer) {
                return true
            }
            if let defaultAnswer = defaultAnswer , answer == "" {
                return defaultAnswer
            }
            customPrint(Prompt.notValidAnswer)
        }
    }
    
    /// Prints a question on standard output, then prints a series of options
    /// and reads one of the option from standard input. It keeps reading until
    /// it reads a valid answer
    /// - returns: the value of the option that was chosen
    public func options<T>(_ options: [T], question: String? = nil, defaultAnswer: T? = nil) -> T? {
        
        guard !options.isEmpty else { return nil}
        guard options.count > 1 else { return options[0] }
        
        // default?
        let defaultText = { Void -> String in
            guard let defaultAnswer = defaultAnswer else { return "" }
            return " (default: \(defaultAnswer))"
        }()
        
        while true {
            
            // question
            if let question = question {
                customPrint(question)
            }
            
            // print options
            customPrint(Prompt.optionsSeparator)
            for index in 0...options.count-1 {
                customPrint("\(index+1)\t\(options[index])")
            }
            customPrint(Prompt.optionsSeparator)
            customPrint(Prompt.choosePrompt + defaultText, terminator: " > ")
            
            // parse answer
            guard let answer = customReadline(true)?.trim else {
                fatalError("EOF?")
            }
            if let defaultAnswer = defaultAnswer , answer == "" {
                return defaultAnswer
            }
            if let index = Int(answer) , (index > 0 && index <= options.count) {
                return options[index - 1]
            }
            customPrint(Prompt.notValidAnswer)
            customPrint("")
        }
    }
}
