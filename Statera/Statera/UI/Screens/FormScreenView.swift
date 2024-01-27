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
    @FocusState private var focusedField: Int?
    @State private var activateNavigation: Bool = false
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
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                toolBar()
            }
        }
        .navigationDestination(
             isPresented: $activateNavigation) {
                  FileUploadView()
             }
    }
    
    @ViewBuilder
    func toolBar() -> some View {
        HStack {
            
            Button(action: {
                focusedField = max((focusedField ?? 0) - 1, 0)
            }, label: {
                Image(systemName: "chevron.backward.square.fill")
            })
            
            Button(action: {
                focusedField = (focusedField ?? 0) + 1
            }, label: {
                Image(systemName: "chevron.forward.square.fill")
            })
            
            Spacer()
            Button(action: {
                UIApplication.shared.endEditing()
            }, label: {
                Image(systemName: "keyboard.chevron.compact.down")
            })
            
        }
    }
    
    @ViewBuilder
    func personalInformationSection() -> some View {
        Section(header: Text("Personal_Information")) {
            TextInputView(viewModel: viewModel.nameViewModel)
                .textContentType(.name)
                .focused($focusedField, equals: 0)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = (focusedField ?? 0) + 1
                }
            SSNInputView(viewModel: viewModel.SSNViewModel)
                .focused($focusedField, equals: 1)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = (focusedField ?? 0) + 1
                }
            DOBInputView(viewModel: viewModel.DOBViewModel)
                .textContentType(.birthdateDay)
                .focused($focusedField, equals: 2)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = (focusedField ?? 0) + 1
                }
            PhoneNumberInputView(viewModel: viewModel.phoneNumberViewModel)
                .textContentType(.telephoneNumber)
                .focused($focusedField, equals: 3)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = (focusedField ?? 0) + 1
                }
        }
    }
    
    @ViewBuilder
    func addressSection() -> some View {
        Section(header: Text("Address")) {
            TextInputView(viewModel: viewModel.addressLine1ViewModel)
                .textContentType(.streetAddressLine1)
                .focused($focusedField, equals: 4)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = (focusedField ?? 0) + 1
                }
            TextInputView(viewModel: viewModel.addressLine2ViewModel)
                .textContentType(.streetAddressLine2)
                .focused($focusedField, equals: 5)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = (focusedField ?? 0) + 1
                }
            TextInputView(viewModel: viewModel.cityViewModel)
                .textContentType(.addressCity)
                .focused($focusedField, equals: 6)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = (focusedField ?? 0) + 1
                }
            PickerInputView(viewModel: viewModel.StateViewModel)
                .textContentType(.addressState)
                .focused($focusedField, equals: 7)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = (focusedField ?? 0) + 1
                }
            ZipCodeInputView(viewModel: viewModel.zipCodeViewModel)
                .textContentType(.postalCode)
                .focused($focusedField, equals: 8)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = (focusedField ?? 0) + 1
                }
        }
    }
    
    @ViewBuilder
    func filingStatusSection() -> some View {
        Section(header: filingStatusHeader() ){
            PickerInputView(viewModel: viewModel.filingStatusViewModel)
                .onReceive(viewModel.filingStatusViewModel.$userInput, perform: { _ in
                    askDependentsNumber = viewModel.shouldAskDependents()
                })
                .focused($focusedField, equals: 9)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = min((focusedField ?? 0) + 1, 1)
                }
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
                    .focused($focusedField, equals: 9)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = min((focusedField ?? 0) + 1, 1)
                    }
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
                            .focused($focusedField, equals: 10 + (index * 3))
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = min((focusedField ?? 0) + 1, 1)
                            }
                        SSNInputView(viewModel: ssnVM)
                            .focused($focusedField, equals: 11 + (index * 3))
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = min((focusedField ?? 0) + 1, 1)
                            }
                        DOBInputView(viewModel: dobVM)
                            .focused($focusedField, equals: 12 + (index * 3))
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = min((focusedField ?? 0) + 1, 1)
                            }
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
                    } else {
                        activateNavigation = true
                    }
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(!viewModel.enableSubmitButton())
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

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
