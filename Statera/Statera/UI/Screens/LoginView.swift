//
//  LoginView.swift
//  Statera
//
//  Created by Ian Hall on 11/10/23.
//

import SwiftUI
import UIKit
import _AuthenticationServices_SwiftUI

struct LoginView: View {
    
    @ObservedObject var viewModel = LoginViewModel()
    @Binding var isLoggedIn: Bool
    @ObservedObject var errorViewModel: ErrorViewModel
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 15) {
                Image("StateraLogo")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                Text("Statera")
                
                Text("Login")
                    .modifier(TitleTextStyle())
                Text("Please_Sign_In")
                    .modifier(TertiaryTextStyle())
                
                EmailInputView(viewModel: viewModel.emailViewModel)
                    .frame(width: 350)
                
                PasswordInputView(viewModel: viewModel.passWordViewModel)
                    .frame(width: 350)
                
                
                Button("Login") {
                    isLoading = true
                    viewModel.handleBaseLogin(completionHandler: { success in
                        isLoading = false
                        if success {
                            self.isLoggedIn = true
                        } else {
                            errorViewModel.errorMessage = "Error_Generic"
                            errorViewModel.showErrorBanner = true
                        }
                    })
                }
                .buttonStyle(PrimaryButtonStyle())
                .frame(width: 200)
                .disabled(!viewModel.isValidCredentials())
                
                SeparatorView()
                SignInWithAppleButton(.signIn) { request in
                    isLoading = true
                    request.requestedScopes = [.fullName, .email]
                } onCompletion: { result in
                    viewModel.handleAppleLogin(result: result, completionHandler: { success in
                        isLoading = false
                        if success {
                            self.isLoggedIn = true
                        } else {
                            errorViewModel.errorMessage = "Login Failed, please check your login credentials and network connectivity"
                            errorViewModel.showErrorBanner = true
                        }
                    })
                }
                .frame(width: 250, height: 50)
                NavigationLink("Create_an_account") {
                    CreateAccountScreen(isLoggedIn: $isLoggedIn, errorViewModel: errorViewModel)
                }
                .buttonStyle(GrayedButton())
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        if isLoading {
            LoadingOverlayView(isLoading: $isLoading)
        }
    }
}

struct SeparatorView: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.black)
                .frame(height: 1)
            Text("or")
                .foregroundColor(.black)
                .padding(.horizontal)
            Rectangle()
                .fill(Color.black)
                .frame(height: 1)
        }
    }
}

#Preview(body: {
    LoginView(isLoggedIn: .constant(false), errorViewModel: ErrorViewModel())
})
