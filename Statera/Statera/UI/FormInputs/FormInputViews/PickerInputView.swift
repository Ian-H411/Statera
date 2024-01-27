//
//  PickerInputView.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import SwiftUI

struct PickerInputView: View {

    @ObservedObject var viewModel: PickerInputViewModel
    
    var body: some View {
        VStack {
            Picker(selection: $viewModel.selectedIndex, label: Text(LocalizedStringKey(viewModel.labelText))) {
                ForEach(0..<viewModel.options.count, id: \.self) { index in
                    Text(LocalizedStringKey(viewModel.options[index]))
                }
            }
            .foregroundColor(viewModel.tintTextColor)
            .pickerStyle(MenuPickerStyle())
            .onAppear(perform: {
                viewModel.setupField()
            })
            .onChange(of: viewModel.selectedIndex) { _, newValue in
                self.viewModel.updateSelection(newValue)
            }
        }
    }
}
