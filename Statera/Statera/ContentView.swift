//
//  ContentView.swift
//  Statera
//
//  Created by Ian Hall on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            LoginView()
        }
        .navigationTitle("Login")
    }
}

#Preview {
    ContentView()
}
