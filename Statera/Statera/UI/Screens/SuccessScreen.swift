//
//  SuccessScreen.swift
//  Statera
//
//  Created by Ian Hall on 2/1/24.
//

import SwiftUI

struct SuccessScreen: View {
    @State private var sendUsAnEmailTapped: Bool = true
    var body: some View {
        VStack(alignment: .center
               , spacing: 20) {
            Image("StateraLogo")
                .resizable()
                .frame(width: 80, height: 80, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .shadow(radius: 10)
            Spacer()
                .frame(height: 50)
            Text("Thank you!")
                .modifier(TitleTextStyle())
            Text("Thank you for submitting, please take a moment to reach out to us so we can begin your taxes!")
            Button(action: {
                // Open the default mail app
                sendUsAnEmailTapped = true
                let email = "martin@stateraaccountingllc.com"
                if let url = URL(string: "mailto:\(email)") {
                    UIApplication.shared.open(url)
                }
            }) {
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                    Text("Send us an email")//TODO: Localize
                        .foregroundColor(.blue)
                }
                .frame(height: 0)
            }
            if sendUsAnEmailTapped {
                Spacer()
                    .frame(height: 40)
                Button("Log_Out") {
                    
                }
                .buttonStyle(PrimaryButtonStyle())
            }
        }
        .padding(.all, 4)
    }
}

#Preview {
    SuccessScreen()
}
