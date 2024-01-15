//
//  ForgotPasswordViewModel.swift
//  Statera
//
//  Created by Ian Hall on 1/13/24.
//

import FirebaseAuth
import Foundation

class ForgotPasswordViewModel: ObservableObject {
    
    @Published var emailAddressField: EmailInputViewModel = EmailInputViewModel(labelText: "Email")
    @Published var passwordResetFieldVM: PasswordResetFieldViewModel = PasswordResetFieldViewModel()
    @Published var newPasswordVM: PasswordInputViewModel = PasswordInputViewModel(labelText: "New Password", displayForgotPassword: false, displayPasswordHint: true)
    
    func sendForgotPasswordEmail(completionHandler: @escaping (Bool) -> Void) {
        let email = emailAddressField.userInput
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("error with sending password reset: \(error.localizedDescription)")
                completionHandler(false)
                return
            }
            completionHandler(true)
            return
        }
    }
    
    func enablePasswordResetWithCodeButton() -> Bool {
        return newPasswordVM.isValid() && passwordResetFieldVM.isValid()
    }
    
    func submitCode(completionHandler: @escaping (Bool) -> Void) {
        let code = passwordResetFieldVM.userInput
        let newPassword = newPasswordVM.userInput
        Auth.auth().confirmPasswordReset(withCode: code,
                                         newPassword: newPassword) { error in
            if let error = error {
                print("\(error.localizedDescription)")
                completionHandler(false)
                return
            }
            completionHandler(true)
            return
        }
    }
}
