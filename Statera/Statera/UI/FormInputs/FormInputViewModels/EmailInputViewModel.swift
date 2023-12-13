//
//  EmailInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 12/12/23.
//

import Foundation

class EmailInputViewModel: FormInputViewModel {
    
    override func updateText(_ newValue: String) {
        self.userInput = newValue
    }
    
    override func isValid() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: userInput)
    }
}
