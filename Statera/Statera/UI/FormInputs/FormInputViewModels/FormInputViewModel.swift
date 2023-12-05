//
//  FormInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import Foundation

class FormInputViewModel: Hashable, Equatable {

    var id: UUID
    var labelText: String
    var isRequired: Bool
    var questionType: InputType
    
    init(labelText: String, isRequired: Bool = true) {
        self.id = UUID()
        self.labelText = labelText
        self.isRequired = isRequired
        self.questionType = .text
    }
    
    static func == (lhs: FormInputViewModel, rhs: FormInputViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum InputType {
    case text
    case currency
    case number
    case ssn
    case dob
    case picker
    case checkBox
}
