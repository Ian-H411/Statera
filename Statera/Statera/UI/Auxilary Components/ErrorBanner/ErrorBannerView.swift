//
//  ErrorBannerView.swift
//  Statera
//
//  Created by Ian Hall on 1/13/24.
//

import SwiftUI

struct ErrorBannerView: View {
    @ObservedObject var errorViewModel: ErrorViewModel
    let frameSize: CGFloat = 45
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
                    
                    HStack {
                        Text(LocalizedStringKey(errorViewModel.errorMessage))
                            .foregroundColor(.white)
                            .padding()
                            .frame(alignment: .leading)
                        if errorViewModel.dismissCountdown > 0 {
                            Text("\(errorViewModel.dismissCountdown)")
                                .foregroundColor(.white)
                                .padding()
                                .background(Circle().stroke(Color.white, lineWidth: 2).frame(width: frameSize, height: frameSize))
                                .frame(width: frameSize, height: frameSize)
                        } else {
                            Button(action: {
                                errorViewModel.showErrorBanner = false
                                errorViewModel.dismissCountdown = 3
                            }) {
                                Text("X")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Circle().stroke(Color.white, lineWidth: 2).frame(width: frameSize, height: frameSize))
                                    .frame(width: frameSize, height: frameSize)
                            }
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
