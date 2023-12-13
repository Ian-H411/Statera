//
//  LoginViewModel.swift
//  Statera
//
//  Created by Ian Hall on 12/12/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var emailViewModel = EmailInputViewModel(labelText: "Email", preFill: "")
    @Published var passWordViewModel = PasswordInputViewModel(labelText: "Password", preFill: "")
    
    func isValidCredentials() -> Bool {
        return emailViewModel.isValid() && passWordViewModel.isValid()
    }
}
