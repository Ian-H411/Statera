//
//  LoginView.swift
//  Statera
//
//  Created by Ian Hall on 11/10/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(spacing: 20) {
            //TODO:- change based on current language
            Button("Spanish") {
                //Toggle to spanish
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding()
            Spacer()
                .frame(height: 20)
            Text("Statera")
            Image(uiImage: UIImage.strokedCheckmark)
                .frame(width: 200, height: 200)
                .scaledToFit()
            Button("Create an account"){
                
            }
            .buttonStyle(PrimaryButtonStyle())
            TextInputView(minCharacters: 3, maxCharacters: 20, displayLabel: "Enter Username", allowedCharacterSet: .alphanumerics)
                .frame(width: 250)
            PasswordInputView(displayLabel: "Enter Password")
                .frame(width: 250)
            Button("Forgot Password") {
                
            }
            .buttonStyle(SecondaryButtonStyle())
            SeparatorView()
            Button("Login with Google") {
                
            }
            Button("Login with Apple") {
                
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

struct LoginView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
