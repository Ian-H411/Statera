//
//  PhoneNumberInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 12/22/23.
//

import Foundation

class PhoneNumberInputViewModel: TextInputViewModel {
    
    init(labelText: String, preFill: String, isRequired: Bool = true) {
        super.init(
            labelText: labelText,
            preFill: preFill,
            minCharacters: 10, // Assuming a 10-digit phone number
            maxCharacters: 10,
            allowedCharacterSet: .decimalDigits,
            isRequired: isRequired
        )
    }
    
    override func updateText(_ newValue: String) {
        self.begunEditing = true
        
        // Remove non-numeric characters
        let filteredText = newValue.filter { char in
            return allowedCharacterSet.contains(char.unicodeScalars.first!)
        }

        // Add hyphen for a better phone number format (e.g., 123-456-7890)
        let formattedText = formatPhoneNumber(filteredText)
        
        // Update the userInput with the formatted text
        self.userInput = formattedText
    }
    
    private func formatPhoneNumber(_ rawPhoneNumber: String) -> String {
        var formattedPhoneNumber = ""
        for (index, char) in rawPhoneNumber.enumerated() {
            if index == 3 || index == 6 {
                formattedPhoneNumber += "-"
            }
            formattedPhoneNumber.append(char)
        }
        return formattedPhoneNumber
    }
}
