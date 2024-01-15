//
//  FormScreenView.swift
//  Statera
//
//  Created by Ian Hall on 12/4/23.
//

import SwiftUI

struct FormScreenView: View {
    @State var viewModel: FormScreenViewModel = FormScreenViewModel()
    @State var askDependentsNumber: Bool = false
    @State var displayDependentInputs: Bool = false
    @ObservedObject var errorViewModel: ErrorViewModel
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            List {
                Section(header: Text("Personal_Information")) {
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
                
                Section(header: Text("Filing_Status")) {
                    PickerInputView(viewModel: viewModel.filingStatusViewModel)
                        .onReceive(viewModel.filingStatusViewModel.$userInput, perform: { _ in
                            askDependentsNumber = viewModel.shouldAskDependents()
                        })
                }
                
                if askDependentsNumber {
                    Section(header: Text("Dependents")) {
                        PickerInputView(viewModel: viewModel.dependentsViewModel)
                            .onReceive(viewModel.dependentsViewModel.$userInput, perform: { _ in
                                displayDependentInputs = false
                                viewModel.updateDependentViewModels()
                                displayDependentInputs = viewModel.numberOfDependentsFields() > 0
                            })
                    }
                }
                if displayDependentInputs && askDependentsNumber {
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
            if isLoading {
                LoadingOverlayView(isLoading: $isLoading)
            }
        }
    }
}

struct FormScreenView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        FormScreenView(errorViewModel: ErrorViewModel())
    }
}
