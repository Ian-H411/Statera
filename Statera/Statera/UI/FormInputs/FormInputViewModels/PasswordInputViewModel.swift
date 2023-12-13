//
//  PasswordInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 12/12/23.
//

import Foundation

class PasswordInputViewModel: FormInputViewModel {
    let minPasswordLength = 8  // Minimum password length, adjust as needed
    private let maxCharacters = 50
    private let allowedCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{}|;:'\",.<>/?`~")
    
   override init(labelText: String, preFill: String, isRequired: Bool = true) {
        super.init(labelText: labelText, preFill: preFill, isRequired: isRequired)
        self.questionType = .password
    }

    override func updateText(_ newValue: String) {
        self.userInput = newValue
    }

    func isValidPassword() -> Bool {
        return userInput.count >= minPasswordLength
                   && userInput.rangeOfCharacter(from: .uppercaseLetters) != nil
                   && userInput.rangeOfCharacter(from: .lowercaseLetters) != nil
                   && userInput.rangeOfCharacter(from: .decimalDigits) != nil
                   && userInput.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()-_=+[]{}|;:'\",.<>/?`~")) != nil
    }
}

// Custom formatter to mask password input
class PasswordFormatter: Formatter {
    override func string(for obj: Any?) -> String? {
        return obj as? String
    }

    override func attributedString(for obj: Any, withDefaultAttributes attrs: [NSAttributedString.Key : Any]? = nil) -> NSAttributedString? {
        return nil
    }

    override func editingString(for obj: Any) -> String? {
        return obj as? String
    }

    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        obj?.pointee = string as AnyObject
        return true
    }
}
