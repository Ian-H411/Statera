//
//  LoadingOverlayView.swift
//  Statera
//
//  Created by Ian Hall on 1/13/24.
//

import SwiftUI

struct LoadingOverlayView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5)
                .ignoresSafeArea()
            
            ProgressView()
                .scaleEffect(2)
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
                .cornerRadius(10)
                .opacity(isLoading ? 1 : 0)
        }
    }
}
