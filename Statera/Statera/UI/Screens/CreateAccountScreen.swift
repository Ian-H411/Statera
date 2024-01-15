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
    @State private var isLoading: Bool = false
    @StateObject var errorViewModel: ErrorViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Text("Create_Account")
                
                EmailInputView(viewModel: createAccountViewModel.emailViewModel)
                    .frame(width: 350)
                PasswordInputView(viewModel: createAccountViewModel.passWordViewModel)
                    .frame(width: 350)
                PasswordInputView(viewModel: createAccountViewModel.confirmPassWordViewModel)
                    .frame(width: 350)
                Button("Create_Account") {
                    isLoading = true
                    createAccountViewModel.baseSignUp(completionHandler: { success in
                        isLoading = false
                        if success {
                            isLoggedIn = true
                        } else {
                            errorViewModel.errorMessage = "error occured while creating account.  please ensure you do not have an active account, or try again."
                        }
                    })
                }
                .buttonStyle(PrimaryButtonStyle())
                SeparatorView()
                SignInWithAppleButton(.signUp) { request in
                    isLoading = true
                    request.requestedScopes = [.email, .fullName]
                } onCompletion: { result in
                    createAccountViewModel.createAccountWithApple(result: result, completionHandler: { success in
                        isLoading = false
                    })
                }
                .frame(width: 250, height: 50)
            }
            if isLoading {
                LoadingOverlayView(isLoading: $isLoading)
            }
        }
    }
}

#Preview {
    CreateAccountScreen(isLoggedIn: .constant(false), errorViewModel: ErrorViewModel())
}
