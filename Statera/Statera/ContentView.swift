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
    @State private var displayMenu = false
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
                if displayMenu {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            displayMenu = false
                        }
                    VStack {
                        HStack {
                            Spacer()
                                .frame(width: .infinity)
                            FloatingMenu(isMenuDisplayed: $displayMenu, isLoggedIn: $isLoggedIn)
                        }
                        
                        Spacer()
                    }
                    .onTapGesture {
                        displayMenu = false
                    }
                }
            }
            .toolbar(content: {
                ToolbarItemGroup(placement: .confirmationAction) {
                    Button(action: {
                        displayMenu.toggle()
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                            .padding()
                    })
                }
            })
        }
        .navigationTitle("Login")

    }
}

#Preview {
    ContentView()
}
