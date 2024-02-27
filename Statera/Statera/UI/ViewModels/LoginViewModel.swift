//
//  LoginViewModel.swift
//  Statera
//
//  Created by Ian Hall on 12/12/23.
//

import Foundation
import AuthenticationServices
import FirebaseAuth
import FirebaseStorage

class LoginViewModel: ObservableObject {
    
    @Published var emailViewModel = EmailInputViewModel(labelText: "Email", preFill: "")
    @Published var passWordViewModel = PasswordInputViewModel(labelText: "Password", displayForgotPassword: true, displayPasswordHint: false)
    
    private var currentUsersEmail: String {
        return Auth.auth().currentUser?.email ?? "UNKNOWN"
    }
    
    func isValidCredentials() -> Bool {
        return emailViewModel.isValid() && passWordViewModel.isValid()
    }
    
    func handleBaseLogin(completionHandler: @escaping (Bool, Bool) -> Void) {
        let email = emailViewModel.userInput
        let password = passWordViewModel.userInput
        baseSignIn(email: email, password: password) { [weak self] success in
            if success {
                self?.hasSubmittedData { hasSubmittedPrior in
                    completionHandler(true, hasSubmittedPrior)
                }
            } else {
                completionHandler(false, false)
            }
        }
    }
    
    //MARK: - sign on handling
    private func baseSignIn(email: String, password: String, completionHandler: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email,
                           password: password) { result, error in
            if let error = error {
                print("login failed \(error.localizedDescription)")
                completionHandler(false)
            } else {
                print("login successful please proceed")
                completionHandler(true)
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
    
    func hasSubmittedData(completionHandler: @escaping (Bool) -> Void) {
        let year = Calendar.current.component(.year, from: Date()) - 1
        let temporaryDirectoryURL = FileManager.default.temporaryDirectory
        let temporaryFileURL = temporaryDirectoryURL.appendingPathComponent("userData.json")
        let submissionsRef = Storage.storage().reference().child("\(currentUsersEmail)").child("\(year)").child("userData.json")
        
        let _ = submissionsRef.write(toFile: temporaryFileURL) { _, error in
            if let _ = error {
                completionHandler(false)
                return
            }
            completionHandler(true)
            return
        }
    }
    
    //MARK: - 3rd party sign in
    
    func handleAppleLogin(result: Result<ASAuthorization, Error>, completionHandler: @escaping (Bool, Bool) -> Void) {
        switch result {
        case .success(let authResult):
            signInApple(ASAuth: authResult, completionHandler: { [weak self] success in
                if success {
                    self?.hasSubmittedData { hasSubmitted in
                        completionHandler(success, hasSubmitted)
                    }
                }
            })
        case .failure(let failure):
            completionHandler(false, false)
            print("Login failed error: \(failure.localizedDescription)")
        }
    }
}
