//
//  FloatingMenu.swift
//  Statera
//
//  Created by Ian Hall on 1/25/24.
//

import SwiftUI

struct FloatingMenu: View {
    @Binding var isMenuDisplayed: Bool
    @Binding var isLoggedIn: LoginStatus
    var body: some View {
        
        VStack {
            if isLoggedIn != .loggedOut {
                Button(action: {
                    isLoggedIn = .loggedOut
                    isMenuDisplayed = false
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.blue)
                            .font(.title)
                        Text("Log_Out")
                            .font(.body)
                            .frame(alignment: .trailing)
                    }
                }
                Rectangle()
                    .frame(height: 1)
            }
            
            Button(action: {
                // TODO: NAV LINK TO CONTACT US PAGE
                isMenuDisplayed = false
            }) {
                NavigationLink(destination: ContactUsScreen()) {
                    HStack {
                        Image(systemName: "person")
                            .foregroundColor(.blue)
                            .font(.title)
                        Text("Contact_US")
                            .font(.body)
                            .frame(alignment: .trailing)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            Rectangle()
                .frame(height: 1)
            Button(action: {
                isMenuDisplayed = false
            }) {
                Image(systemName: "xmark.square")
                    .foregroundColor(.red)
                    .font(.title)
                Text("Close_Menu")
                    .font(.body)
                    .frame(alignment: .trailing)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
        }
        .padding()
        .background(.white)
        .border(.black, width: 2)
        .cornerRadius(10)
        .shadow(color: Color.gray, radius: 5, x: 0, y: 2)
    }
}

#Preview {
    FloatingMenu(isMenuDisplayed: .constant(true), isLoggedIn: .constant(.loggedIn))
}
