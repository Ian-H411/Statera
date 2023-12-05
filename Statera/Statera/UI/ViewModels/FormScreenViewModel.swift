//
//  FormScreenViewModel.swift
//  Statera
//
//  Created by Ian Hall on 12/4/23.
//

import Foundation

class FormScreenViewModel {
    
    var inputs = [[FormInputViewModel]]()
    
    init() {
        createBaseViewModelsForPersonalTax()
    }
    
    func createBaseViewModelsForPersonalTax() {
        let fullNameVM = TextInputViewModel(labelText: "Full Name", isRequired: true)
        let email = TextInputViewModel(labelText: "Email")
        let phoneNumber = NumberInputViewModel(labelText: "Phone Number")
        let social = SSNInputViewModel(labelText: "Social Security Number")
        let dob = DOBInputViewModel(labelText: "Date of Birth")
        let addressLine1 = TextInputViewModel(labelText: "Address Line 1")
        let addressLine2 = TextInputViewModel(labelText: "Address Line 2")
        let city = TextInputViewModel(labelText: "City")
        let state = PickerInputViewModel(labelText: "State")
        let zipCode = NumberInputViewModel(labelText: "zip Code")
        let filingStatus = PickerInputViewModel(labelText: "Filing Status")
        inputs = [[fullNameVM, email, phoneNumber], [social, dob], [addressLine1, addressLine2, city, state, state, zipCode], [filingStatus]]
    }
}
