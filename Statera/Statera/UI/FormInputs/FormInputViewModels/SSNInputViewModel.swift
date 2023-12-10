//
//  SSNInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import Foundation

class SSNInputViewModel: FormInputViewModel {
    
    override init(labelText: String, preFill: String,  isRequired: Bool = true) {
        super.init(labelText: labelText, preFill: preFill, isRequired: isRequired)
        self.questionType = .ssn
    }
}
