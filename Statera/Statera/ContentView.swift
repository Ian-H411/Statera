//
//  ContentView.swift
//  Statera
//
//  Created by Ian Hall on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            if isLoggedIn {
                FormScreenView()
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
        .navigationTitle("Login")
    }
}

#Preview {
    ContentView()
}
