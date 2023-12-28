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
    
    @Published var firstNameViewModel = TextInputViewModel(labelText: "First_Name", preFill: "", minCharacters: 3, maxCharacters: 25, allowedCharacterSet: .alphanumerics)
    @Published var lastNameViewModel = TextInputViewModel(labelText: "Last_Name", preFill: "", minCharacters: 3, maxCharacters: 25, allowedCharacterSet: .alphanumerics)
    @Published var emailViewModel = EmailInputViewModel(labelText: "Email", preFill: "")
    
    @Published var passWordViewModel = PasswordInputViewModel(labelText: "Password", preFill: "")
    @Published var confirmPassWordViewModel = PasswordInputViewModel(labelText: "Confirm Password", preFill: "")
    
    //MARK: - Additional Validation
    
    private func passwordsMatch() -> Bool {
        return (passWordViewModel.userInput == confirmPassWordViewModel.userInput) && (passWordViewModel.begunEditing && confirmPassWordViewModel.begunEditing)
    }
    
    //MARK: - Create Account
    
    func baseSignUp(completionHandler: @escaping (Bool) -> Void) {
        let email = emailViewModel.userInput
        let password = passWordViewModel.userInput
        Auth.auth().createUser(withEmail: email,
                               password: password) { authResult, error in
            if let error = error {
                completionHandler(false)
                print("error creating account \(error.localizedDescription)")
            } else {
                completionHandler(true)
            }
        }
    }
    
    private func signInApple(ASAuth: ASAuthorization, completionHandler: @escaping (Bool) -> Void) {
        if let appleIDCredential = ASAuth.credential as? ASAuthorizationAppleIDCredential {
            guard let identityTokenData = appleIDCredential.identityToken,
                  let identityTokenString = String(data: identityTokenData, encoding: .utf8) else {
                print("Identity token is missing.")
                completionHandler(false)
                return
            }

            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: identityTokenString, rawNonce: nil)
            Auth.auth().signIn(with: credential) { AuthDataResult, error in
                if let error = error {
                    print("firebase sign in failure: \(error.localizedDescription)")
                    completionHandler(false)
                } else {
                    completionHandler(true)
                    print("successful Sign in")
                }
            }
        }
    }
    
    func createAccountWithApple(result: Result<ASAuthorization, Error>, completionHandler: @escaping (Bool) -> Void) {
        switch result {
        case .success(let authResult):
            signInApple(ASAuth: authResult) { success in
                completionHandler(success)
            }
        case .failure(let error):
            completionHandler(false)
            print("sign in failed\(error.localizedDescription)")
        }
    }
}
