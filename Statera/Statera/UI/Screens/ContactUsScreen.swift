//
//  ContactUsScreen.swift
//  Statera
//
//  Created by Ian Hall on 1/27/24.
//

import SwiftUI

struct ContactUsScreen: View {
    @State private var deletionConfirmation = false
    @Binding var isLoggedIn: LoginStatus
    @State var viewModel = ContactUsViewModel()
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack {
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
                    if isLoggedIn  != .loggedOut {
                        Section {
                            Button(action: {
                                deletionConfirmation.toggle()
                            }, label: {
                                HStack {
                                    Image(systemName: "trash.fill")
                                        .foregroundColor(.red)
                                        .frame(width: 20)
                                    Text("deleteAcct")
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .frame(height: 0)
                            })
                            .alert(isPresented: $deletionConfirmation) {
                                Alert(
                                    title: Text("confirmDeletion"),
                                    message: Text("deleteConfirmationAccountMessage"),
                                    primaryButton: .default(Text("Cancel")),
                                    secondaryButton: .destructive(Text("Delete")) {
                                        // Perform deletion
                                        isLoading = true
                                        viewModel.deleteAccount { _ in
                                            isLoggedIn = .loggedOut
                                            isLoading = false
                                        }
                                    }
                                )
                            }
                        }
                    }
                }
            }
            .background(Color(.systemGray6))
            .edgesIgnoringSafeArea(.all)
            if isLoading {
                LoadingOverlayView(isLoading: $isLoading)
            }
        }
    }
    
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactUsScreen(isLoggedIn: .constant(.loggedIn))
        }
    }
}
