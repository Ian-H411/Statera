//
//  ContentView.swift
//  Statera
//
//  Created by Ian Hall on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    @State private var isFirstLogin = false
    @StateObject private var errorViewModel = ErrorViewModel()
    @State private var displayMenu = false
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
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
                    flowDirector()
                }
                popUpMenu()
            }
            .toolbar(content: {
                ToolbarItemGroup(placement: .confirmationAction) {
                    hamburgerMenuContent()
                }
            })
        }
        .navigationTitle("Login")
    }
    
    @ViewBuilder
    func flowDirector() -> some View {
        if isLoggedIn && isFirstLogin {
            FormScreenView(errorViewModel: errorViewModel)
        } else if isLoggedIn && isFirstLogin {
            HomeScreen(errorViewModel: errorViewModel)
        } else {
            LoginView(isLoggedIn: $isLoggedIn, errorViewModel: errorViewModel)
        }
    }
    
    @ViewBuilder
    func popUpMenu() -> some View {
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
    
    @ViewBuilder
    func hamburgerMenuContent() -> some View {
        Button(action: {
            displayMenu.toggle()
        }, label: {
            Image(systemName: "line.horizontal.3")
                .imageScale(.large)
                .padding()
        })
    }
}

#Preview {
    ContentView()
}
