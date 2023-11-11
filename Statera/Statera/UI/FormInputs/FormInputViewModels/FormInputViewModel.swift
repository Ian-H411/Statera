//
//  FormInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import Foundation

class FormInputViewModel {
    
    var labelText: String
    var isRequired: Bool
    
    init(labelText: String, isRequired: Bool = true) {
        self.labelText = labelText
        self.isRequired = isRequired
    }
}
