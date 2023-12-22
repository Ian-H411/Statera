//
//  FormScreenViewModel.swift
//  Statera
//
//  Created by Ian Hall on 12/4/23.
//

import Foundation

class FormScreenViewModel: ObservableObject {
    
    @Published var nameViewModel = TextInputViewModel(labelText: "Full Name", preFill: "", minCharacters: 5, maxCharacters: 30, allowedCharacterSet: .alphanumerics)
    @Published var SSNViewModel = SSNInputViewModel(labelText: "Social Security Number")
    @Published var DOBViewModel = TextInputViewModel(labelText: "Date of Birth", preFill: "", minCharacters: 6, maxCharacters: 8, allowedCharacterSet: .decimalDigits)
    @Published var phoneNumberViewModel = TextInputViewModel(labelText: "Phone Number", preFill: "", minCharacters: 10, maxCharacters: 10, allowedCharacterSet: .decimalDigits)
    
    @Published var addressLine1ViewModel = TextInputViewModel(labelText: "Address Line 1", preFill: "", minCharacters: 5, maxCharacters: 50, allowedCharacterSet: .alphanumerics)
    @Published var addressLine2ViewModel = TextInputViewModel(labelText: "Address Line 2", preFill: "", minCharacters: 5, maxCharacters: 50, allowedCharacterSet: .alphanumerics)
    @Published var cityViewModel = TextInputViewModel(labelText: "City", preFill: "", minCharacters: 4, maxCharacters: 20, allowedCharacterSet: .alphanumerics)
    @Published var StateViewModel = TextInputViewModel(labelText: "State", preFill: "", minCharacters: 2, maxCharacters: 20, allowedCharacterSet: .alphanumerics)
    @Published var zipCodeViewModel = TextInputViewModel(labelText: "ZipCode", preFill: "", minCharacters: 5, maxCharacters: 10, allowedCharacterSet: .decimalDigits)
    
    @Published var filingStatusViewModel = TextInputViewModel(labelText: "Filing Status", preFill: "", minCharacters: 3, maxCharacters: 20, allowedCharacterSet: .alphanumerics)
}
