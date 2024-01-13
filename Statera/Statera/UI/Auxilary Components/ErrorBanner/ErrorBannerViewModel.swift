//
//  ErrorBannerViewModel.swift
//  Statera
//
//  Created by Ian Hall on 1/13/24.
//

import Foundation

class ErrorViewModel: ObservableObject {
    @Published var showErrorBanner = false
    @Published var errorMessage = "an unexpected error has occured"
    @Published var dismissCountdown = 3

    func showErrorMessage(_ message: String) {
        errorMessage = message
        showErrorBanner = true
        startDismissCountdown()
    }

    func startDismissCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.dismissCountdown > 0 {
                self.dismissCountdown -= 1
            } else {
                timer.invalidate()
            }
        }
    }
}
