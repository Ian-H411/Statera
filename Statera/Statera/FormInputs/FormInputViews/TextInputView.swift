//
//  TextInputView.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import SwiftUI

struct TextInputView: View {
    //TODO:- Change to Binding
    @State var text: String = "hello"
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
    }
}


struct TextInputView_Previews: PreviewProvider {
    static var previews: some View {
        TextInputView(minCharacters: 2, maxCharacters: 12, allowedCharacterSet: .alphanumerics)
    }
}
