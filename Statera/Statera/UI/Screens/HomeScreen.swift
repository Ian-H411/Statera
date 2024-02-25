//
//  HomeScreen.swift
//  Statera
//
//  Created by Ian Hall on 11/10/23.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var errorViewModel: ErrorViewModel
    @Binding var loginStatus: LoginStatus
    var body: some View {
        VStack {
            Spacer()
            Image("StateraLogo")
                .resizable()
                .frame(width: 80, height: 80, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .shadow(radius: 10)
            Spacer()
                .frame(height: 30)
            Text("welcome")
                .modifier(TitleTextStyle())
                .padding(4)
            List {
                NavigationLink("resubmit") {
                    FormScreenView(isLoggedIn: $loginStatus, errorViewModel: errorViewModel)
                }
                .foregroundColor(.blue)
                .fontWeight(.bold)
                
                NavigationLink("uploadMore") {
                    FileUploadScreen(loginStatus: $loginStatus)
                }
                .foregroundColor(.blue)
                .fontWeight(.bold)
            }
        }
        .background(Color.init(uiColor: .systemGray6))
    }
}

struct HomeScreen_PreviewProvider: PreviewProvider {
    static var previews: some View {
        HomeScreen(errorViewModel: ErrorViewModel(), loginStatus: .constant(.loggedIn))
    }
}
