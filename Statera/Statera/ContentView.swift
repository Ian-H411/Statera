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
            ZStack{
                Image("StateraBackground")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                if isLoggedIn {
                    FormScreenView()
                } else {
                    FileUploadView()
                }
            }
        }
        .navigationTitle("Login")
    }
}

#Preview {
    ContentView()
}
