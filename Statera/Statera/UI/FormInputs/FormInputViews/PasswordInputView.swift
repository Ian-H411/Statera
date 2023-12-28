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
    let formatter = PasswordFormatter()
    
    var body: some View {
        VStack {
            HStack {
                TextField(viewModel.labelText, value: $viewModel.userInput, formatter: formatter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                if isForgotPasswordVisible {
                    //TODO: - change this out once forgot password screen is created
                    NavigationLink(destination: FormScreenView()) {
                        Text("Forgot_Password")
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }
            }

            if !viewModel.isValidPassword() {
                Text(String(format: NSLocalizedString("Password_requirements", comment: ""), viewModel.minPasswordLength))
                    .foregroundColor(.red)
                    .padding(.top, 4)
            }
        }
        .onAppear(perform: {
            isForgotPasswordVisible = viewModel.isForgotPasswordButtonVisible
        })
    }
}

struct PasswordInputView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        let vm = PasswordInputViewModel(labelText: "password please", displayForgotPassword: true)
        PasswordInputView(viewModel: vm)
    }
}
