//
//  TextInputView.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import SwiftUI

struct TextInputView: View {

    @ObservedObject var viewModel: TextInputViewModel
    var keyboardType: UIKeyboardType = .default
    
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
                .onAppear(perform: {
                    if viewModel.userInput.count < viewModel.minCharacters {
                        viewModel.userInput = String(repeating: " ", count: viewModel.minCharacters)
                    } else if viewModel.userInput.count > viewModel.maxCharacters {
                        viewModel.userInput = String(viewModel.userInput.prefix(viewModel.maxCharacters))
                    }
                })
                .onChange(of: viewModel.userInput, initial: true) { _, newValue in
                    viewModel.updateText(newValue)
                }
                .keyboardType(keyboardType)
        }
    }
}



struct TextInputView_Previews: PreviewProvider {
    static var previews: some View {
        let previewViewModel = TextInputViewModel(labelText: "First Name",
                                           preFill: "David",
                                           minCharacters: 3,
                                           maxCharacters: 20,
                                           allowedCharacterSet: .alphanumerics)
        TextInputView(viewModel: previewViewModel)
    }
}
