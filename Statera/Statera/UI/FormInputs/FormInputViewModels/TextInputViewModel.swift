//
//  TextInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import SwiftUI

class TextInputViewModel: FormInputViewModel {
    var minCharacters: Int
    var maxCharacters: Int
    var allowedCharacterSet: CharacterSet
    
    var keyboardType: UIKeyboardType {
        return allowedCharacterSet == .decimalDigits ? .decimalPad : .default
    }

    init(labelText: String, preFill: String, minCharacters: Int, maxCharacters: Int, allowedCharacterSet: CharacterSet, isRequired: Bool = true) {
        self.minCharacters = minCharacters
        self.maxCharacters = maxCharacters
        if allowedCharacterSet == .alphanumerics {
            self.allowedCharacterSet = allowedCharacterSet.union(CharacterSet(charactersIn: " "))
        } else {
            self.allowedCharacterSet = allowedCharacterSet
        }
        super.init(labelText: labelText, preFill: preFill, isRequired: isRequired)
        self.questionType = .text
    }
    
    override func updateText(_ newValue: String) {
        self.begunEditing = true
        let filteredText = newValue.filter { char in
            guard let unicodeScaler = char.unicodeScalars.first else { return false }
            return allowedCharacterSet.contains(unicodeScaler)
        }

        if filteredText.count > maxCharacters {
            self.userInput = String(filteredText.prefix(maxCharacters))
        } else {
            self.userInput = filteredText
        }
    }
    
    func setupField() {
        if userInput.count < minCharacters {
            userInput = String(repeating: " ", count: minCharacters)
        } else if userInput.count > maxCharacters {
            userInput = String(userInput.prefix(maxCharacters))
        }
    }
}
