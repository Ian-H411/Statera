//
//  HomeScreen.swift
//  Statera
//
//  Created by Ian Hall on 11/10/23.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack {
            Text("Welcome To Statera")
            NavigationLink("Start on your taxes") {
                
            }
                .buttonStyle(PrimaryButtonStyle())
                .frame(width: 200, height: 200)
            NavigationLink("File Business Texes with Statera") {
                
            }
                .buttonStyle(PrimaryButtonStyle())
                .frame(width: 200, height: 200)
            Image(uiImage: UIImage.checkmark)
                .frame(width: 100, height: 100)
        }
    }
}

struct HomeScreen_PreviewProvider: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
