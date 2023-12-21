//
//  CreateAccountViewModel.swift
//  Statera
//
//  Created by Ian Hall on 12/20/23.
//

import Foundation
import FirebaseAuth
import AuthenticationServices

class CreateAccountViewModel: ObservableObject {
    
    @Published var firstNameViewModel = TextInputViewModel(labelText: "First Name", preFill: "", minCharacters: 3, maxCharacters: 25, allowedCharacterSet: .alphanumerics)
    @Published var lastNameViewModel = TextInputViewModel(labelText: "Last Name", preFill: "", minCharacters: 3, maxCharacters: 25, allowedCharacterSet: .alphanumerics)
    @Published var emailViewModel = EmailInputViewModel(labelText: "Email", preFill: "")
    
    @Published var passWordViewModel = PasswordInputViewModel(labelText: "Password", preFill: "")
    @Published var confirmPassWordViewModel = PasswordInputViewModel(labelText: "Confirm Password", preFill: "")
    
    //MARK: - Additional Validation
    
    private func passwordsMatch() -> Bool {
        return (passWordViewModel.userInput == confirmPassWordViewModel.userInput) && (passWordViewModel.begunEditing && confirmPassWordViewModel.begunEditing)
    }
    
    //MARK: - Create Account
    
    func baseSignUp() {
        guard passwordsMatch() else { return }
        let email = emailViewModel.userInput
        let password = passWordViewModel.userInput
        Auth.auth().createUser(withEmail: email,
                               password: password) { authResult, error in
            if let error = error {
                print("error creating account \(error.localizedDescription)")
            } else {
                //successful account creation
            }
        }
    }
    
    func createAccountWithApple(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResult):
            print("handle successful apple auth")
        case .failure(let error):
            print("sign in failed\(error.localizedDescription)")
        }
    }
}
