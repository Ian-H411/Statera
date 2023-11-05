//
//  CurrencyInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import SwiftUI

struct CurrencyInputView: View {
    //TODO:- Change to Binding
    @State var text: String = ""
    var minCharacters: Int
    var maxCharacters: Int
    var displayLabel: String
    var allowedCharacterSet: CharacterSet
    var keyboardType: UIKeyboardType = .numberPad
    
    var body: some View {
        VStack {
            if !text.isEmpty {
                Text(displayLabel)
                    .alignmentGuide(.leading) { _ in 0 }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .transition(AnyTransition.opacity.animation(.smooth(duration: 0.2)))
                    .foregroundColor(.gray)
                    
            }
            TextField(displayLabel, value: $text, formatter: Formatter())
                .onAppear(perform: {
                    if text.count < minCharacters {
                        text = String(repeating: " ", count: minCharacters)
                    } else if text.count > maxCharacters {
                        text = String(text.prefix(maxCharacters))
                    }
                })
                .onChange(of: text, initial: true) { _, newValue in
                    let filteredText = newValue.filter { char in
                        guard let unicodeScaler = char.unicodeScalars.first else { return false }
                        return allowedCharacterSet.contains(unicodeScaler)
                    }
                    if filteredText.count > maxCharacters {
                        text = String(filteredText.prefix(maxCharacters))
                    } else {
                        text = filteredText
                    }
                }
                .keyboardType(keyboardType)
        }
    }
}

struct CurrencyInputView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        CurrencyInputView(minCharacters: 0, maxCharacters: 100, displayLabel: "Whats your yearly income?", allowedCharacterSet: .decimalDigits)
    }
}
