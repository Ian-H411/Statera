//
//  DOBInputView.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import SwiftUI

struct DOBInputView: View {
    @ObservedObject var viewModel: DOBInputViewModel

    var body: some View {
        VStack {
            TextField(viewModel.labelText, text: $viewModel.userInput)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: viewModel.userInput, perform: { newValue in
                    viewModel.updateText(newValue)
                })

            if !viewModel.isValid() {
                Text("Invalid DOB")
                    .foregroundColor(.red)
                    .padding(.top, 4)
            }
        }
    }
}
