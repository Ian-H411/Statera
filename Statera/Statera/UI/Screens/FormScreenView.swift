//
//  FormScreenView.swift
//  Statera
//
//  Created by Ian Hall on 12/4/23.
//

import SwiftUI

struct FormScreenView: View {
    @State var viewModel: FormScreenViewModel = FormScreenViewModel()
    
    var body: some View {
        ScrollView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextInputView(viewModel: viewModel.nameViewModel)
                    SSNInputView(viewModel: viewModel.SSNViewModel)
                    DOBInputView(viewModel: viewModel.DOBViewModel)
                    TextInputView(viewModel: viewModel.phoneNumberViewModel) // create phone number input later
                }
                
                Section(header: Text("Address")) {
                    TextInputView(viewModel: viewModel.addressLine1ViewModel)
                    TextInputView(viewModel: viewModel.addressLine2ViewModel)
                    TextInputView(viewModel: viewModel.cityViewModel)
                    TextInputView(viewModel: viewModel.StateViewModel) // create City dropdown later
                    TextInputView(viewModel: viewModel.zipCodeViewModel) // Create custom zip code input later
                }
                
                Section(header: Text("Filing Status")) {
                    TextInputView(viewModel: viewModel.filingStatusViewModel) // to be used with drop down later
                }
                Section {
                    Button("Submit") {
                        
                    }
                }
            }
        }
    }
}


let previewViewModel = FormScreenViewModel()
struct FormScreenView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        FormScreenView(viewModel: previewViewModel)
    }
}
