//
//  SSNInputView.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import SwiftUI

struct SSNInputView: View {
    @ObservedObject var viewModel: SSNInputViewModel

    var body: some View {
        VStack {
            TextField(viewModel.labelText, text: $viewModel.userInput)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: viewModel.userInput, initial: false) { _, newValue  in
                    viewModel.updateText(newValue)
                }

            if !viewModel.isValidSSN() {
                Text("Invalid SSN")
                    .foregroundColor(.red)
                    .padding(.top, 4)
            }
        }
    }
}
