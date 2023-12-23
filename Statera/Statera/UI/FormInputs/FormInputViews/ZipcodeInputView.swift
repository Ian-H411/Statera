//
//  ZipcodeInputView.swift
//  Statera
//
//  Created by Ian Hall on 12/22/23.
//

import SwiftUI

struct ZipCodeInputView: View {

    @ObservedObject var viewModel: ZipCodeInputViewModel
    
    var body: some View {
        VStack {
            if !viewModel.userInput.isEmpty {
                Text(viewModel.labelText)
                    .alignmentGuide(.leading) { _ in 0 }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(AnyTransition.opacity.animation(.smooth(duration: 0.2)))
                    .foregroundColor(.gray)
            }
            
            TextField(
                viewModel.labelText,
                text: $viewModel.userInput
            )
            .onAppear(perform: {
                viewModel.setupField()
            })
            .onChange(of: viewModel.userInput, { _, newValue in
                viewModel.updateText(newValue)
            })
            .keyboardType(viewModel.keyboardType)
        }
    }
}
