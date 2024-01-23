//
//  DOBInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import Foundation

class DOBInputViewModel: FormInputViewModel {
    
    override init(labelText: String, preFill: String = "", isRequired: Bool = true) {
        super.init(labelText: labelText, preFill: preFill, isRequired: isRequired)
        self.questionType = .dob
    }
    
    func updateText(oldValue: String, newValue: String) {
        self.begunEditing = true
        let cleanedDOB = newValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        var formattedDOB = ""
        var index = cleanedDOB.startIndex
        
        if let finalCharOfOld = oldValue.last,
           determineIfBackSpace(oldValue: oldValue, newValue: newValue) && finalCharOfOld == "/" {
            formattedDOB = String(cleanedDOB.dropLast())
        } else {
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
        }

        self.userInput = formattedDOB
    }
    
    private func determineIfBackSpace(oldValue: String, newValue: String) -> Bool {
        return oldValue.count > newValue.count
    }
    
    override func isValid() -> Bool {
        guard self.begunEditing else { return true }
        return userInput.count == "XX/XX/XXXX".count
    }
}
