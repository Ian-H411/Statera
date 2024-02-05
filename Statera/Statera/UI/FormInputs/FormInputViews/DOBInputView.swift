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
                Text(LocalizedStringKey(viewModel.labelText))
                    .alignmentGuide(.leading) { _ in 0 }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(AnyTransition.opacity.animation(.smooth(duration: 0.2)))
                    .foregroundColor(viewModel.tintTextColor)
                    
            }
            ToggleableSecureField(title: viewModel.labelText, text: $viewModel.userInput, prompt: nil)
                .environment(\.secureToggleImageShow, Image(systemName: "eye.circle"))
                .environment(\.secureToggleImageHide, Image(systemName: "eye.slash.circle"))
                .environment(\.secureToggleImageTintColor, .blue)
                .keyboardType(.numberPad)
                .onChange(of: viewModel.userInput, initial: false) { oldValue, newValue  in
                    viewModel.updateText(oldValue: oldValue, newValue: newValue)
                }

            if !viewModel.isValid() && viewModel.begunEditing {
                Text("Invalid_DOB")
                    .foregroundColor(.red)
                    .alignmentGuide(.leading, computeValue: { _ in 0 })
            }
        }
    }
}

struct DOBInputView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        let dobInputViewModel = DOBInputViewModel(labelText: "DOB", over18: true)
        DOBInputView(viewModel: dobInputViewModel)
    }
}
