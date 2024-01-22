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
    @State private var isSheetPresented = false
    
    var body: some View {
        ZStack {
            List {
                personalInformationSection()
                addressSection()
                filingStatusSection()
                numberOfDependentsSection()
                multiDependentInputView()
                submitButton()
            }
            .listStyle(InsetGroupedListStyle())
            if isLoading {
                LoadingOverlayView(isLoading: $isLoading)
            }
        }
    }
    
    @ViewBuilder
    func personalInformationSection() -> some View {
        Section(header: Text("Personal_Information")) {
            TextInputView(viewModel: viewModel.nameViewModel)
            SSNInputView(viewModel: viewModel.SSNViewModel)
            DOBInputView(viewModel: viewModel.DOBViewModel)
            PhoneNumberInputView(viewModel: viewModel.phoneNumberViewModel)
        }
    }
    
    @ViewBuilder
    func addressSection() -> some View {
        Section(header: Text("Address")) {
            TextInputView(viewModel: viewModel.addressLine1ViewModel)
            TextInputView(viewModel: viewModel.addressLine2ViewModel)
            TextInputView(viewModel: viewModel.cityViewModel)
            PickerInputView(viewModel: viewModel.StateViewModel)
            ZipCodeInputView(viewModel: viewModel.zipCodeViewModel)
        }
    }
    
    @ViewBuilder
    func filingStatusSection() -> some View {
        Section(header: filingStatusHeader() ){
            PickerInputView(viewModel: viewModel.filingStatusViewModel)
                .onReceive(viewModel.filingStatusViewModel.$userInput, perform: { _ in
                    askDependentsNumber = viewModel.shouldAskDependents()
                })
        }
    }
    
    @ViewBuilder
    func filingStatusHeader() -> some View {
        Button {
            isSheetPresented.toggle()
        } label: {
            HStack {
                Text("Filing_Status")
                    .font(.footnote)
                Image(systemName: "questionmark.circle")
            }
        }
        .sheet(isPresented: $isSheetPresented,
               content: {
            MoreInfoSheet(textToDisplay: viewModel.filingStatusInfo, isSheetPresented: $isSheetPresented)
                .presentationDetents([.height(400), .medium, .large])
                .presentationDragIndicator(.automatic)
        })
    }
    
    @ViewBuilder
    func numberOfDependentsSection() -> some View {
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
    }
    
    
    @ViewBuilder
    func multiDependentInputView() -> some View {
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
    }
    
    @ViewBuilder
    func submitButton() -> some View {
        HStack(alignment: .center) {
            Spacer()
                .frame(width: 45)
            Button("Submit") {
                guard viewModel.enableSubmitButton() else { return }
                isLoading = true
                viewModel.submitData { success in
                    isLoading = false
                    if !success {
                        errorViewModel.errorMessage = "Error Uploading information please try again"
                        errorViewModel.showErrorBanner = true
                    }
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .frame(width: 200)
            Spacer()
                .frame(width: 45)
        }
    }
}

struct FormScreenView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        FormScreenView(errorViewModel: ErrorViewModel())
    }
}
