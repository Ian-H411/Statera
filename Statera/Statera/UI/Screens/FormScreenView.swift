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
            List {
                Section(header: Text("Personal Information")) {
                    TextInputView(viewModel: viewModel.nameViewModel)
                    SSNInputView(viewModel: viewModel.SSNViewModel)
                    DOBInputView(viewModel: viewModel.DOBViewModel)
                    PhoneNumberInputView(viewModel: viewModel.phoneNumberViewModel)
                }
                
                Section(header: Text("Address")) {
                    TextInputView(viewModel: viewModel.addressLine1ViewModel)
                    TextInputView(viewModel: viewModel.addressLine2ViewModel)
                    TextInputView(viewModel: viewModel.cityViewModel)
                    PickerInputView(viewModel: viewModel.StateViewModel)
                    ZipCodeInputView(viewModel: viewModel.zipCodeViewModel)
                }
                
                Section(header: Text("Filing Status")) {
                    PickerInputView(viewModel: viewModel.filingStatusViewModel) // to be used with drop down later
                }
                
                if viewModel.shouldAskDependents() {
                    Section(header: Text("Dependents")) {
                        PickerInputView(viewModel: viewModel.dependentsViewModel)
                    }
                }
                if viewModel.numberOfDependentsFields() > 0 {
                    ForEach(0..<viewModel.numberOfDependentsFields(), id: \.self) { index in
                        Section(header: Text("Dependent \(index + 1)")) {
                            let inputViewModels = viewModel.dependentsInfoViewModels[index]
                            if let nameVM = inputViewModels[0] as? TextInputViewModel,
                               let ssnVM = inputViewModels[1] as? SSNInputViewModel,
                               let dobVM = inputViewModels[2] as? DOBInputViewModel {
                                TextInputView(viewModel: nameVM)
                                SSNInputView(viewModel: ssnVM)
                                DOBInputView(viewModel: dobVM)
                            }
                        }
                    }
                }
                Section {
                    Button("Submit") {
                        
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .onChange(of: viewModel.numberOfDependentsFields()) { _, _ in
            viewModel.updateDependentViewModels()
        }
    }
}

struct FormScreenView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        FormScreenView()
    }
}
