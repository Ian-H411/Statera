//
//  PasswordInputView.swift
//  Statera
//
//  Created by Ian Hall on 11/10/23.
//

import SwiftUI

struct PasswordInputView: View {
    @ObservedObject var viewModel: PasswordInputViewModel
    @State private var isForgotPasswordVisible: Bool = false
    @State private var displayPasswordHint: Bool = false
    
    let formatter = PasswordFormatter()
    
    var body: some View {
        VStack {
            HStack {
                SecureField(LocalizedStringKey(viewModel.labelText), text: $viewModel.userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                if isForgotPasswordVisible {
                    NavigationLink(destination: ForgotPasswordScreen()) {
                        Text("Forgot_Password")
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }
            }
            if displayPasswordHint {
                PasswordRequirementsView(viewModel: viewModel)
            }
        }
        .onAppear(perform: {
            isForgotPasswordVisible = viewModel.isForgotPasswordButtonVisible
            displayPasswordHint = viewModel.displayPasswordHint
        })
    }
}

private struct PasswordRequirementsView: View {
    @ObservedObject var viewModel: PasswordInputViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Password_requirements_title")
                .foregroundColor(.gray)
                .font(.subheadline)
            Text("Password_Requirements")
                .foregroundColor(viewModel.isValidPassword() ? .green : .gray)
                .font(.footnote)
                
        }
    }
}

struct PasswordInputView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        let vm = PasswordInputViewModel(labelText: "password please", displayForgotPassword: false, displayPasswordHint: true)
        PasswordInputView(viewModel: vm)
    }
}
