//
//  FormScreenViewModel.swift
//  Statera
//
//  Created by Ian Hall on 12/4/23.
//

import Foundation

class FormScreenViewModel: ObservableObject {
    
    static let stateCodes = [
        "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
        "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
        "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
        "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
        "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"
    ]
    
    enum FilingStatus: String {
        case single = "Single"
        case marriedFilingJoint = "Married_Filing_Joint"
        case headOfHousehold = "Head_of_Household"
    }
    
    static let filingStatusOptions: [String] = [FilingStatus.single.rawValue, FilingStatus.marriedFilingJoint.rawValue, FilingStatus.headOfHousehold.rawValue]
    
    static let dependents = ["0","1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    @Published var nameViewModel = TextInputViewModel(labelText: "Full_Name", preFill: "", minCharacters: 5, maxCharacters: 30, allowedCharacterSet: .alphanumerics)
    @Published var SSNViewModel = SSNInputViewModel(labelText: "Social Security Number")
    @Published var DOBViewModel = DOBInputViewModel(labelText: "Date of Birth")
    @Published var phoneNumberViewModel = PhoneNumberInputViewModel(labelText: "Phone_Number", preFill: "")
    
    @Published var addressLine1ViewModel = TextInputViewModel(labelText: "Address_Line_1", preFill: "", minCharacters: 5, maxCharacters: 50, allowedCharacterSet: .alphanumerics)
    @Published var addressLine2ViewModel = TextInputViewModel(labelText: "Address Line 2", preFill: "", minCharacters: 5, maxCharacters: 50, allowedCharacterSet: .alphanumerics)
    @Published var cityViewModel = TextInputViewModel(labelText: "City", preFill: "", minCharacters: 4, maxCharacters: 20, allowedCharacterSet: .alphanumerics)
    @Published var StateViewModel = PickerInputViewModel(labelText: "State", options: stateCodes)
    @Published var zipCodeViewModel = ZipCodeInputViewModel(labelText: "Zip_Code", preFill: "")
    
    @Published var filingStatusViewModel = PickerInputViewModel(labelText: "Filing_Status", options: filingStatusOptions)
    
    @Published var dependentsViewModel = PickerInputViewModel(labelText: "How_Many_Dependents?", options: dependents)
    
    @Published var dependentsInfoViewModels: [[FormInputViewModel]] = []
    
    func shouldAskDependents() -> Bool {
        return FilingStatus(rawValue: filingStatusViewModel.userInput) != .single
    }
    
    func numberOfDependentsFields() -> Int {
        return Int(dependentsViewModel.userInput) ?? 0
    }
    
    func updateDependentViewModels() {
        let baseDependentArray: [FormInputViewModel] = [
            TextInputViewModel(labelText: "Full_Name", preFill: "", minCharacters: 5, maxCharacters: 30, allowedCharacterSet: .alphanumerics),
            SSNInputViewModel(labelText: "Social_Security_Number"),
            DOBInputViewModel(labelText: "Date_of_Birth")
        ]
        dependentsInfoViewModels = Array(repeating: baseDependentArray, count: numberOfDependentsFields())
    }
}
