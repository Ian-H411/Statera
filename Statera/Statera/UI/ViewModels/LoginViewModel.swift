//
//  LoginViewModel.swift
//  Statera
//
//  Created by Ian Hall on 12/12/23.
//

import Foundation
import AuthenticationServices
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    @Published var emailViewModel = EmailInputViewModel(labelText: "Email", preFill: "")
    @Published var passWordViewModel = PasswordInputViewModel(labelText: "Password", preFill: "")
    
    func isValidCredentials() -> Bool {
        return emailViewModel.isValid() && passWordViewModel.isValid()
    }
    
    
    //MARK: - 3rd party sign in
    
    func handleAppleLogin(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResult):
            signIn(ASAuth: authResult)
            print("login successful via Apple Sign in")
        case .failure(let failure):
            print("Login failed error: \(failure.localizedDescription)")
        }
    }
    
    private func signIn(ASAuth: ASAuthorization) {
        if let appleIDCredential = ASAuth.credential as? ASAuthorizationAppleIDCredential {
            guard let identityTokenData = appleIDCredential.identityToken,
                  let identityTokenString = String(data: identityTokenData, encoding: .utf8) else {
                print("Identity token is missing.")
                return
            }

            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: identityTokenString, rawNonce: nil)
            Auth.auth().signIn(with: credential) { AuthDataResult, error in
                if let error = error {
                    print("firebase sign in failure: \(error.localizedDescription)")
                } else {
                    print("successful Sign in")
                }
            }
            
        }
    }
}
