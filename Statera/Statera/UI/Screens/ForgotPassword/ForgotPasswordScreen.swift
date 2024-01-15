//
//  ForgotPasswordScreen.swift
//  Statera
//
//  Created by Ian Hall on 1/13/24.
//

import SwiftUI

struct ForgotPasswordScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ForgotPasswordViewModel = ForgotPasswordViewModel()
    @State private var codeSent: Bool = false
    @StateObject private var errorViewModel = ErrorViewModel()
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                if errorViewModel.showErrorBanner {
                    Spacer()
                    ErrorBannerView(errorViewModel: errorViewModel)
                        .frame(width: 330, height: 120)
                }
                Text("Statera Accounting")
                    .modifier(TitleTextStyle())
                    .frame(height: 100)
                Image("StateraLogo")
                    .resizable()
                    .frame(width: 80, height: 80, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                Spacer()
                    .frame(height: 20)
                
                Text("Forgot Password?")
                EmailInputView(viewModel: viewModel.emailAddressField)
                Button("Reset Password") {
                    guard viewModel.emailAddressField.isValid() else { return }
                    viewModel.sendForgotPasswordEmail { success in
                        if success {
                            codeSent = true
                        }
                    }
                }
                .buttonStyle(PrimaryButtonStyle())
                Spacer()
                    .frame(height: 150)
            }
            if isLoading {
                LoadingOverlayView(isLoading: $isLoading)
            }
        }
    }
}

#Preview {
    ForgotPasswordScreen(viewModel: ForgotPasswordViewModel())
}
