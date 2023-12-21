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
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Create an account \n with Statera")
                Image(uiImage: UIImage.checkmark)
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
            TextInputView(viewModel: createAccountViewModel.firstNameViewModel)
            TextInputView(viewModel: createAccountViewModel.lastNameViewModel)
            EmailInputView(viewModel: createAccountViewModel.emailViewModel)
                .frame(width: 250)
            PasswordInputView(viewModel: createAccountViewModel.passWordViewModel)
                .frame(width: 250)
            PasswordInputView(viewModel: createAccountViewModel.confirmPassWordViewModel)
                .frame(width: 250)
            Button("Create Account") {
                createAccountViewModel.baseSignUp()
            }
            .buttonStyle(PrimaryButtonStyle())
            SeparatorView()
            Button("Sign in with Google") {
                
            }
            SignInWithAppleButton(.signUp) { request in
                request.requestedScopes = [.email, .fullName]
            } onCompletion: { result in
                createAccountViewModel.createAccountWithApple(result: result)
            }
        }
    }
}

struct CreateAccountScreen_PreviewProvider: PreviewProvider {
    static var previews: some View {
        CreateAccountScreen()
    }
}
