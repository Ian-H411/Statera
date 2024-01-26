//
//  ErrorBannerView.swift
//  Statera
//
//  Created by Ian Hall on 1/13/24.
//

import SwiftUI

struct ErrorBannerView: View {
    @ObservedObject var errorViewModel: ErrorViewModel

    var body: some View {
        if errorViewModel.showErrorBanner {
            ZStack {
                Color.red
                    .cornerRadius(10) // Rounded corners
                HStack {
                    Rectangle()
                        .fill(Color.orange)
                        .frame(width: 5)
                        .padding(.leading, 5)
                    
                    VStack {
                        Text(LocalizedStringKey(errorViewModel.errorMessage))
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                        if errorViewModel.dismissCountdown > 0 {
                            Text("\(errorViewModel.dismissCountdown)")
                                .foregroundColor(.white)
                                .padding()
                                .background(Circle().stroke(Color.white, lineWidth: 2))
                        } else {
                            Button(action: {
                                errorViewModel.showErrorBanner = false
                                errorViewModel.dismissCountdown = 3
                            }) {
                                Text("Dismiss")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.white, lineWidth: 2))
                            }
                            Spacer()
                                .frame(height: 10)
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear {
                // Start countdown when the banner appears
                errorViewModel.startDismissCountdown()
            }
        }
    }
}
