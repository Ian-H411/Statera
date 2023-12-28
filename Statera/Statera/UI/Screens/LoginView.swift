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
        VStack(spacing: 15) {
            Image("StateraLogo")
                .frame(width: 220, height: 220, alignment: .center)
                .scaledToFit()
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
                viewModel.handleBaseLogin(completionHandler: { success in
                    if success {
                        self.isLoggedIn = true
                    }
                })
            }
            .buttonStyle(PrimaryButtonStyle())
            .frame(width: 200)
            .disabled(!viewModel.isValidCredentials())
            
            SeparatorView()
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                viewModel.handleAppleLogin(result: result)
            }
            .frame(width: 250, height: 50)
            NavigationLink("Create_an_account") {
                CreateAccountScreen(isLoggedIn: $isLoggedIn)
            }
            .buttonStyle(GrayedButton())
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

#Preview(body: {
    LoginView(isLoggedIn: .constant(false))
})
