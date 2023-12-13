//
//  FormInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import Foundation

class FormInputViewModel: Hashable, Equatable, ObservableObject {

    @Published var userInput: String = ""
    var id: UUID
    var labelText: String
    var isRequired: Bool
    var questionType: InputType
    
    init(labelText: String, preFill: String, isRequired: Bool = true) {
        self.id = UUID()
        self.userInput = preFill
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
    
    func updateText(_ newValue: String) { }
    func isValid() -> Bool { return true }
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
