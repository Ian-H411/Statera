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
            Text("thanks_submit")
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
                    Text("sendEmail")//TODO: Localize
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
