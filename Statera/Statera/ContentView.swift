//
//  ContentView.swift
//  Statera
//
//  Created by Ian Hall on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    @StateObject private var errorViewModel = ErrorViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack{
                Image("StateraBackground")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    if errorViewModel.showErrorBanner {
                        Spacer()
                        ErrorBannerView(errorViewModel: errorViewModel)
                            .frame(width: 330, height: 120)
                    }
                    if isLoggedIn {
                        FormScreenView(errorViewModel: errorViewModel)
                    } else {
                        LoginView(isLoggedIn: $isLoggedIn, errorViewModel: errorViewModel)
                    }
                    
                }
            }
        }
        .navigationTitle("Login")
    }
}

#Preview {
    ContentView()
}
