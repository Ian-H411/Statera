//
//  PhoneNumberInputView.swift
//  Statera
//
//  Created by Ian Hall on 12/22/23.
//

import SwiftUI

struct PhoneNumberInputView: View {

    @ObservedObject var viewModel: PhoneNumberInputViewModel
    
    var body: some View {
        VStack {
            if !viewModel.userInput.isEmpty {
                Text(LocalizedStringKey(viewModel.labelText))
                    .alignmentGuide(.leading) { _ in 0 }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(AnyTransition.opacity.animation(.smooth(duration: 0.2)))
                    .foregroundColor(.gray)
            }
            
            TextField(
                LocalizedStringKey(viewModel.labelText),
                text: $viewModel.userInput
            )
            .onAppear(perform: {
                viewModel.setupField()
            })
            .onChange(of: viewModel.userInput,
                      initial: false, { _, newValue in
                viewModel.updateText(newValue)
            })
            .keyboardType(viewModel.keyboardType)
            if !viewModel.isValid() {
                Text("Invalid_PhoneNumber")
                    .foregroundColor(.red)
                    .alignmentGuide(.leading, computeValue: { _ in 0 })
            }
        }
    }
}
