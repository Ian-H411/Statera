//
//  PasswordInputView.swift
//  Statera
//
//  Created by Ian Hall on 11/10/23.
//

import SwiftUI

struct PasswordInputView: View {
    @State private var password: String = ""
    
       var displayLabel: String

       var body: some View {
           VStack {
               if !password.isEmpty {
                   Text(displayLabel)
                       .alignmentGuide(.leading) { _ in 0 }
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .transition(AnyTransition.opacity.animation(.smooth(duration: 0.2)))
                       .foregroundColor(.gray)
               }

               SecureField(displayLabel, text: $password)
                   .onAppear {
                       // Additional setup if needed
                   }
                   .keyboardType(.default) // You can customize the keyboard type if needed
           }
       }
}

struct PasswordInputView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        PasswordInputView(displayLabel: "Enter Password")
    }
}
