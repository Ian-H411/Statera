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
    
    override init(labelText: String, preFill: String = "", isRequired: Bool = true) {
        self.allowedCharacterSet = CharacterSet.decimalDigits
        super.init(labelText: labelText, preFill: preFill, isRequired: isRequired)
        self.questionType = .ssn
    }

    func updateText(oldValue: String, newValue: String) {
        self.begunEditing = true
        let didBackSpace = isBackSpace(oldValue: oldValue, newValue: newValue)
        let cleanedSSN = newValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var formattedSSN = ""
        var index = cleanedSSN.startIndex
        
        if let finalCharOfOld = oldValue.last,
           didBackSpace && finalCharOfOld == "-" {
            formattedSSN = String(cleanedSSN.dropLast())
        } else {
            for character in "XXX-XX-XXXX" {
                if character == "X" {
                    if index < cleanedSSN.endIndex {
                        formattedSSN.append(cleanedSSN[index])
                        index = cleanedSSN.index(after: index)
                    } else {
                        break
                    }
                } else {
                    formattedSSN.append(character)
                }
            }
        }
        self.userInput = formattedSSN
    }
    
    private func isBackSpace(oldValue: String, newValue: String) -> Bool {
        return oldValue.count > newValue.count
    }

    func isValidSSN() -> Bool {
        guard self.begunEditing else { return true }
        let ssnTest = NSPredicate(format:"SELF MATCHES %@", ssnRegex)
        return ssnTest.evaluate(with: userInput)
    }
}
