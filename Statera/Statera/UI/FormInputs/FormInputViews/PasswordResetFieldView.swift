//
//  PasswordResetFieldView.swift
//  Statera
//
//  Created by Ian Hall on 1/13/24.
//

import SwiftUI

struct PasswordResetFieldView: View {
    @ObservedObject var viewModel: PasswordResetFieldViewModel
    
    var body: some View {
        TextField("Enter code", text: $viewModel.userInput)
            .frame(width: 200, height: 30)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .padding()
            .onChange(of: viewModel.userInput) { _, newValue in
                if newValue.count > 6 {
                    viewModel.userInput = String(newValue.prefix(6))
                }
            }
    }
    
}


#Preview {
    PasswordResetFieldView(viewModel: PasswordResetFieldViewModel())
}
