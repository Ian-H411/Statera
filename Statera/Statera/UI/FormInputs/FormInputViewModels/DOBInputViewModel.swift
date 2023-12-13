//
//  DOBInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import Foundation

class DOBInputViewModel: FormInputViewModel {
    
    override init(labelText: String, preFill: String, isRequired: Bool = true) {
        super.init(labelText: labelText, preFill: preFill, isRequired: isRequired)
        self.questionType = .dob
    }
    
    override func updateText(_ newValue: String) {
        let cleanedDOB = newValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        var formattedDOB = ""
        var index = cleanedDOB.startIndex
        
        for character in "XX/XX/XXXX" {
            if character == "X" {
                if index < cleanedDOB.endIndex {
                    formattedDOB.append(cleanedDOB[index])
                    index = cleanedDOB.index(after: index)
                } else {
                    break
                }
            } else {
                formattedDOB.append(character)
            }
        }

        self.userInput = formattedDOB
    }
    
    override func isValid() -> Bool {
        return userInput.count == "XX/XX/XXXX".count
    }
}
