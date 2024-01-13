//
//  ForgotPasswordScreen.swift
//  Statera
//
//  Created by Ian Hall on 1/13/24.
//

import SwiftUI

struct ForgotPasswordScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ForgotPasswordViewModel = ForgotPasswordViewModel()
    @State private var codeSent: Bool = true
    
    var body: some View {
        VStack {
            Text("Statera Accounting")
                .modifier(TitleTextStyle())
                .frame(height: 100)
            Image("StateraLogo")
                .resizable()
                .frame(width: 80, height: 80, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .shadow(radius: 10)
            Spacer()
                .frame(height: 20)
            if !codeSent {
                Text("Forgot Password?")
                EmailInputView(viewModel: viewModel.emailAddressField)
                Button("Reset Password") {
                    viewModel.sendForgotPasswordEmail { success in
                        if success {
                            codeSent = true
                        }
                    }
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(viewModel.emailAddressField.isValid())
            } else {
                Text("Please input code sent to: \n\(viewModel.emailAddressField.userInput)")
                PasswordResetFieldView(viewModel: viewModel.passwordResetFieldVM)
                PasswordInputView(viewModel: viewModel.newPasswordVM)
                    .frame(height: 150)
                Button("Change Password") {
                    viewModel.submitCode { success in
                        if success {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(viewModel.enablePasswordResetWithCodeButton())
                Spacer()
                    .frame(height: 20)
                Button("Resend password reset email") {
                    viewModel.sendForgotPasswordEmail { _ in
                    
                    }
                }
                .buttonStyle(SecondaryButtonStyle())
            }
            Spacer()
                .frame(height: 150)
        }
    }
}

#Preview {
    ForgotPasswordScreen(viewModel: ForgotPasswordViewModel())
}
