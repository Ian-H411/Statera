//
//  DOBInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import Foundation

class DOBInputViewModel: FormInputViewModel {
    var isOver18Verification: Bool
    
    init(labelText: String, preFill: String = "", isRequired: Bool = true, over18: Bool) {
        self.isOver18Verification = over18
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        guard let date = dateFormatter.date(from: userInput) else {
            // Invalid date format
            return false
        }

        // Check if the date is in the past
        guard date < Date() else {
            return false
        }

        // Calculate age
        let calendar = Calendar.current
        if let age = calendar.dateComponents([.year], from: date, to: Date()).year,
           let minAgeDate = calendar.date(byAdding: .year, value: -120, to: Date()),
           let maxAgeDate = calendar.date(byAdding: .year, value: -18, to: Date()) {
            // Check if age is within the desired range (18 to 120)
            if isOver18Verification {
                return age >= 18 && date > minAgeDate && date < maxAgeDate
            } else {
                return  date > minAgeDate
            }
            
        }

        return false
    }
}
