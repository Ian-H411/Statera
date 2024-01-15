//
//  PasswordResetFieldViewModel.swift
//  Statera
//
//  Created by Ian Hall on 1/13/24.
//

import Foundation

class PasswordResetFieldViewModel: FormInputViewModel {
    init() {
        super.init(labelText: "")
    }
    
    override func isValid() -> Bool {
        return self.userInput.count == 6
    }
}
