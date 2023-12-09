//
//  TextInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import Foundation

class TextInputViewModel: FormInputViewModel {
    var minCharacters: Int
    var maxCharacters: Int
    var allowedCharacterSet: CharacterSet

    init(labelText: String, preFill: String, minCharacters: Int, maxCharacters: Int, allowedCharacterSet: CharacterSet, isRequired: Bool = true) {
        self.minCharacters = minCharacters
        self.maxCharacters = maxCharacters
        self.allowedCharacterSet = allowedCharacterSet
        super.init(labelText: labelText, preFill: preFill, isRequired: isRequired)
        self.questionType = .text
    }
    
    func updateText(_ newValue: String) {
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
}
