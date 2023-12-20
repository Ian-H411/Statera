//
//  CurrencyInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import Foundation

class CurrencyInputViewModel: FormInputViewModel {
    
    var minCharacters: Int
    var maxCharacters: Int
    var allowedCharacterSet: CharacterSet = .decimalDigits

    init(labelText: String, preFill: String, minCharacters: Int, maxCharacters: Int, isRequired: Bool = true) {
        self.minCharacters = minCharacters
        self.maxCharacters = maxCharacters
        super.init(labelText: labelText, preFill: preFill, isRequired: isRequired)
        self.questionType = .currency
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
