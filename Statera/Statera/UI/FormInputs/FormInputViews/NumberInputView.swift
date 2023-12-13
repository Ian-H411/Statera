//
//  NumberInputView.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import SwiftUI

struct NumberInputView: View {
    var minCharacters: Int
    var maxCharacters: Int
    var charSet: CharacterSet = .decimalDigits
    var displayLabel: String
    var keyboardType: UIKeyboardType = .numberPad
    
    var body: some View {
        TextInputView(viewModel: <#T##TextInputViewModel#>)
    }
}

struct NumberInputView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        NumberInputView(minCharacters: 0, maxCharacters: 4, displayLabel: "How many employees?")
    }
}
