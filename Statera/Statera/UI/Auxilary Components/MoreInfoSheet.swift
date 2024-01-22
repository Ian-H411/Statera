//
//  MoreInfoSheet.swift
//  Statera
//
//  Created by Ian Hall on 1/21/24.
//

import SwiftUI

struct MoreInfoSheet: View {
    let textToDisplay: String
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        VStack {
            Text(LocalizedStringKey(textToDisplay))
                .font(.body)
                .padding()
            Button("Close") {
                dismiss()
            }
            .padding()
            .buttonStyle(PrimaryButtonStyle())
        }
    }
    
    private func dismiss() {
        isSheetPresented = false
    }
}
