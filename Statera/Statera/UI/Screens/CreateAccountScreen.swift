//
//  CreateAccountScreen.swift
//  Statera
//
//  Created by Ian Hall on 11/10/23.
//

import SwiftUI
import _AuthenticationServices_SwiftUI
struct CreateAccountScreen: View {
    
    var createAccountViewModel = CreateAccountViewModel()
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Create_Account")
            
            EmailInputView(viewModel: createAccountViewModel.emailViewModel)
                .frame(width: 250)
            PasswordInputView(viewModel: createAccountViewModel.passWordViewModel)
                .frame(width: 250)
            PasswordInputView(viewModel: createAccountViewModel.confirmPassWordViewModel)
                .frame(width: 250)
            Button("Create_Account") {
                createAccountViewModel.baseSignUp(completionHandler: { success in
                    isLoggedIn = true
                })
            }
            .buttonStyle(PrimaryButtonStyle())
            SeparatorView()
            SignInWithAppleButton(.signUp) { request in
                request.requestedScopes = [.email, .fullName]
            } onCompletion: { result in
                createAccountViewModel.createAccountWithApple(result: result, completionHandler: { success in
                    
                })
            }
            .frame(width: 250, height: 50)
        }
    }
}

#Preview {
    CreateAccountScreen(isLoggedIn: .constant(false))
}
