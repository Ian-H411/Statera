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
                TextField(LocalizedStringKey(viewModel.labelText), value: $viewModel.userInput, formatter: formatter)
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
            Text("Password Must contain at least:")
                .foregroundColor(.gray)
                .font(.subheadline)
            // Change the color based on password strength conditions
            Text("One Uppercase letter \nOne Number \nOne Special Character:  !?/;")
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
