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
            if !viewModel.userInput.isEmpty {
                Text(viewModel.labelText)
                    .alignmentGuide(.leading) { _ in 0 }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(AnyTransition.opacity.animation(.smooth(duration: 0.2)))
                    .foregroundColor(.gray)
                    
            }
            TextField(viewModel.labelText, text: $viewModel.userInput)
                .keyboardType(.numberPad)
                .onChange(of: viewModel.userInput, initial: false) { _, newValue  in
                    viewModel.updateText(newValue)
                }

            if !viewModel.isValid() {
                Text("Invalid DOB")
                    .foregroundColor(.red)
                    .alignmentGuide(.leading, computeValue: { _ in 0 })
            }
        }
    }
}

struct DOBInputView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        let dobInputViewModel = DOBInputViewModel(labelText: "DOB")
        DOBInputView(viewModel: dobInputViewModel)
    }
}
