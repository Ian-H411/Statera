//
//  PickerInputViewModel.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import Foundation

class PickerInputViewModel: FormInputViewModel {
    var options: [String]
    @Published var selectedIndex: Int
    
    init(labelText: String, selectedIndex: Int, options: [String], isRequired: Bool = true) {
        self.options = options
        self.selectedIndex = selectedIndex
        super.init(labelText: labelText, preFill: "", isRequired: isRequired)
        self.questionType = .picker
    }
}
