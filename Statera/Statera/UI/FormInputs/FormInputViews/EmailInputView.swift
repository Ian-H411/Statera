//
//  EmailInputView.swift
//  Statera
//
//  Created by Ian Hall on 12/12/23.
//

import SwiftUI

struct EmailInputView: View {
    @ObservedObject var viewModel: EmailInputViewModel
    
    var body: some View {
        VStack {
            TextField(viewModel.labelText, text: $viewModel.userInput)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: viewModel.userInput, initial: false) { _, newValue in
                    viewModel.updateText(newValue)
                }

            if !viewModel.isValid() {
                Text("Invalid Email")
                    .foregroundColor(.red)
                    .padding(.top, 4)
            }
        }
    }
}
