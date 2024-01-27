//
//  FormInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import SwiftUI

class FormInputViewModel: Hashable, Equatable, ObservableObject {

    @Published var userInput: String = ""
    @Published var tintTextColor: Color = .gray
    private var tintTextRed: Bool = false
    
    var id: UUID
    var labelText: String
    var isRequired: Bool
    var questionType: InputType
    var begunEditing: Bool = false
    
    init(labelText: String, preFill: String = "", isRequired: Bool = true) {
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
    func isValid() -> Bool { return !userInput.isEmpty }
    
    func toggleLabelTint() {
        tintTextRed.toggle()
        if tintTextRed {
            tintTextColor = .red
        } else {
            tintTextColor = .gray
        }
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
    case password
    case emailAddress
}
