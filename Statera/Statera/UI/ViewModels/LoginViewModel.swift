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
    
    func handleBaseLogin() {
        guard isValidCredentials() else { return }
        let email = emailViewModel.userInput
        let password = passWordViewModel.userInput
        baseSignIn(email: email, password: password) { success in
            if success {
                // push users into app
            } else {
                //failed
            }
        }
    }
    
    //MARK: - sign on handling
    private func baseSignIn(email: String, password: String, completionHandler: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email,
                           password: password) { result, error in
            if let error = error {
                print("login failed \(error.localizedDescription)")
            } else {
                print("login successful please proceed")
            }
        }
    }
    
    /// used for apple sign on
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
    
    //MARK: - 3rd party sign in
    
    func handleAppleLogin(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authResult):
            signInApple(ASAuth: authResult, completionHandler: { success in
                print("successFull auth please proceed")
            })
        case .failure(let failure):
            print("Login failed error: \(failure.localizedDescription)")
        }
    }
}
