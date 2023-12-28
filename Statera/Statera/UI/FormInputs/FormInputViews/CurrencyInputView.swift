//
//  CurrencyInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import SwiftUI

struct CurrencyInputView: View {
    @ObservedObject var viewModel: CurrencyInputViewModel
    var keyboardType: UIKeyboardType = .numberPad
    
    var body:  some View {
        VStack {
            if !viewModel.userInput.isEmpty {
                Text(LocalizedStringKey(viewModel.labelText))
                    .alignmentGuide(.leading) { _ in 0 }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(AnyTransition.opacity.animation(.smooth(duration: 0.2)))
                    .foregroundColor(.gray)
                    
            }
            TextField(LocalizedStringKey(viewModel.labelText), value: $viewModel.userInput, formatter: Formatter())
                .onAppear(perform: {
                    viewModel.setupField()
                })
                .onChange(of: viewModel.userInput, initial: true) { _, newValue in
                    viewModel.updateText(newValue)
                }
                .keyboardType(keyboardType)
        }
    }
}

struct CurrencyInputView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        let viewModel = CurrencyInputViewModel(labelText: "Whats your annual income?", 
                                               preFill: "20",
                                               minCharacters: 0,
                                               maxCharacters: 15)
        CurrencyInputView(viewModel: viewModel)
    }
}
