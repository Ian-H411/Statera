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
    
    init(labelText: String, options: [String], preSelectedIndex: Int = 0) {
        self.options = options
        self.selectedIndex = preSelectedIndex
        super.init(labelText: labelText)
        self.userInput = options[preSelectedIndex]
    }
    
    func updateSelection(_ newIndex: Int) {
        self.userInput = options[newIndex]
        self.labelText = options[newIndex]
    }
    
    func setupField() {
        // Setup initial field state if needed
    }
}
