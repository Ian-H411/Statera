//
//  TextInputView.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import SwiftUI

struct TextInputView: View {
    @Binding var text: String
    var minCharacters: Int
    var maxCharacters: Int
    var allowedCharacterSet: CharacterSet
    
    var body: some View {
        TextField("Enter Text", text: $text)
            .onAppear(perform: {
                if text.count < minCharacters {
                    text = String(repeating: " ", count: minCharacters)
                } else if text.count > maxCharacters {
                    text = String(text.prefix(maxCharacters))
                }
            })
            .onChange(of: text, initial: true) { _, newValue in
                let filteredText = newValue.filter { allowedCharacterSet.contains($0) }
                if filteredText.count > maxCharacters {
                    text = String(filteredText.prefix(maxCharacters))
                } else {
                    text = filteredText
                }
            }
    }
}


#Preview {
    TextInputView(text: "hi", minCharacters: 2, maxCharacters: 8, allowedCharacterSet: .alphanumerics)
}
