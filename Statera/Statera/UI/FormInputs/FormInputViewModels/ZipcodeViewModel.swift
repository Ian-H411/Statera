//
//  ZipcodeViewModel.swift
//  Statera
//
//  Created by Ian Hall on 12/22/23.
//

import Foundation

class ZipCodeInputViewModel: TextInputViewModel {
    
    init(labelText: String, preFill: String, isRequired: Bool = true) {
        super.init(
            labelText: labelText,
            preFill: preFill,
            minCharacters: 5, // Assuming a 5-digit zip code
            maxCharacters: 10, // You can adjust this based on your requirements
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

        // Update the userInput with the filtered text
        self.userInput = filteredText
    }
}
