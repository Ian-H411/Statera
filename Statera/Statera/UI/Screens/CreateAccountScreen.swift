//
//  CreateAccountScreen.swift
//  Statera
//
//  Created by Ian Hall on 11/10/23.
//

import SwiftUI

struct CreateAccountScreen: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Create an account \n with Statera")
                Image(uiImage: UIImage.checkmark)
                    .scaledToFit()
                    .frame(width: 150, height: 150)
            }
            TextInputView(minCharacters: 3, maxCharacters: 20, displayLabel: "First Name", allowedCharacterSet: .alphanumerics)
                .frame(width: 250)
            TextInputView(minCharacters: 3, maxCharacters: 20, displayLabel: "Last Name", allowedCharacterSet: .alphanumerics)
                .frame(width: 250)
            TextInputView(minCharacters: 3, maxCharacters: 20, displayLabel: "Email", allowedCharacterSet: .alphanumerics)
                .frame(width: 250)
            PasswordInputView(displayLabel: "Password")
                .frame(width: 250)
            PasswordInputView(displayLabel: "Confrim Password")
                .frame(width: 250)
            Button("Create Account") {
                
            }
            .buttonStyle(PrimaryButtonStyle())
            SeparatorView()
            Button("Sign in with Google") {
                
            }
            Button("Sign in with Apple") {
                
            }
        }
    }
}

struct CreateAccountScreen_PreviewProvider: PreviewProvider {
    static var previews: some View {
        CreateAccountScreen()
    }
}
