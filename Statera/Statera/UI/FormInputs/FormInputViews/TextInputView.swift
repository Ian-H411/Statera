//
//  TextInputView.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import SwiftUI

struct TextInputView: View {

    @ObservedObject var viewModel: TextInputViewModel
    
    var body: some View {
        VStack {
            if !viewModel.userInput.isEmpty {
                Text(LocalizedStringKey(viewModel.labelText))
                    .alignmentGuide(.leading) { _ in 0 }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(AnyTransition.opacity.animation(.smooth(duration: 0.2)))
                    .foregroundColor(.gray)
                    
            }
            TextField(LocalizedStringKey(viewModel.labelText), text: $viewModel.userInput)
                .onAppear(perform: {
                    viewModel.setupField()
                })
                .onChange(of: viewModel.userInput, initial: true) { _, newValue in
                    viewModel.updateText(newValue)
                }
                .keyboardType(viewModel.keyboardType)
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
