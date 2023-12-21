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
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 20)
            Text("Statera")

            Image(uiImage: UIImage.strokedCheckmark)
                .frame(width: 200, height: 200)
                .scaledToFit()

            NavigationLink("Create an account") {
                CreateAccountScreen(isLoggedIn: $isLoggedIn)
            }
            .buttonStyle(PrimaryButtonStyle())

            EmailInputView(viewModel: viewModel.emailViewModel)
                .frame(width: 250)

            PasswordInputView(viewModel: viewModel.passWordViewModel)
                .frame(width: 250)

            Button("Login") {
                viewModel.handleBaseLogin(completionHandler: { success in
                    if success {
                        self.isLoggedIn = true
                    }
                })
            }
            .buttonStyle(PrimaryButtonStyle())
            .frame(width: 200)
            .disabled(!viewModel.isValidCredentials())
            
            NavigationLink("Forgot Password") {
                
            }
            .buttonStyle(SecondaryButtonStyle())
            SeparatorView()
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                viewModel.handleAppleLogin(result: result)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
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
