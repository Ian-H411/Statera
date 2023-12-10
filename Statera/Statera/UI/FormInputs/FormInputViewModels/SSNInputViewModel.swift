//
//  SSNInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import Foundation

class SSNInputViewModel: FormInputViewModel {
    
    private let ssnRegex = "^(?!666|000|9\\d{2})\\d{3}-(?!00)\\d{2}-(?!0{4})\\d{4}$"
    
    var allowedCharacterSet: CharacterSet
    var minCharacters: Int
    var maxCharacters: Int
    
    override init(labelText: String, preFill: String, isRequired: Bool = true) {
        self.allowedCharacterSet = CharacterSet.decimalDigits
        self.minCharacters = 9
        self.maxCharacters = 9
        super.init(labelText: labelText, preFill: preFill, isRequired: isRequired)
        self.questionType = .ssn
    }

    func updateText(_ newValue: String) {
        let filteredText = newValue.filter { char in
            guard let unicodeScaler = char.unicodeScalars.first else { return false }
            return allowedCharacterSet.contains(unicodeScaler)
        }
        self.userInput = String(filteredText.prefix(maxCharacters))
    }

    func isValidSSN() -> Bool {
        let ssnTest = NSPredicate(format:"SELF MATCHES %@", ssnRegex)
        return ssnTest.evaluate(with: userInput)
    }
}
