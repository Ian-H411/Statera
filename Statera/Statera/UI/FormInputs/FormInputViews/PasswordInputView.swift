//
//  PasswordInputView.swift
//  Statera
//
//  Created by Ian Hall on 11/10/23.
//

import SwiftUI

struct PasswordInputView: View {
    @ObservedObject var viewModel: PasswordInputViewModel
    let formatter = PasswordFormatter()
    
    var body: some View {
        VStack {
            TextField(viewModel.labelText, value: $viewModel.userInput, formatter: formatter)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if !viewModel.isValidPassword() {
                Text(String(format: NSLocalizedString("Password_requirements", comment: ""), viewModel.minPasswordLength))
                    .foregroundColor(.red)
                    .padding(.top, 4)
            }
        }
    }
}

struct PasswordInputView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        let vm = PasswordInputViewModel(labelText: "password please", preFill: "")
        PasswordInputView(viewModel: vm)
    }
}
