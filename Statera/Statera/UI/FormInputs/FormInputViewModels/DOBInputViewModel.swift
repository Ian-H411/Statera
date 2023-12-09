//
//  DOBInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import Foundation

class DOBInputViewModel: FormInputViewModel {
    
    override init(labelText: String, isRequired: Bool = true) {
        super.init(labelText: labelText, isRequired: isRequired)
        self.questionType = .dob
    }
}
