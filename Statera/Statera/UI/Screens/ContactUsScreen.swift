//
//  ContactUsScreen.swift
//  Statera
//
//  Created by Ian Hall on 1/27/24.
//

import SwiftUI

struct ContactUsScreen: View {
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 90)
            Image("StateraLogo")
                .resizable()
                .frame(width: 80, height: 80, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .shadow(radius: 10)
            Spacer()
                .frame(height: 20)
            List {
                Section {
                    HStack {
                        Spacer()
                            .frame(width: 17)
                        Image(systemName: "globe")
                        Link("VisitWebsite", destination: URL(string: "https://stateraaccountingllc.com")!)
                            .foregroundColor(.blue)
                    }
                    HStack {
                        // Email link
                        Button(action: {
                            // Open the default mail app
                            let email = "martin@stateraaccountingllc.com"
                            if let url = URL(string: "mailto:\(email)") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.black)
                                Text("sendEmail")
                                    .foregroundColor(.blue)
                            }
                            .frame(height: 0)
                        }
                        .padding()
                    }
                    
                } header: {
                    Text("getInTouch")
                        .font(.title)
                        .padding()
                }
            }
        }
        .background(Color(.systemGray6))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactUsScreen()
        }
    }
}
