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
            Picker(viewModel.labelText, selection: $viewModel.selectedIndex) {
                ForEach(0..<viewModel.options.count, id: \.self) { index in
                    Text(viewModel.options[index])
                        .tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
        }
    }
}


struct PickerInputView_Previews: PreviewProvider {
    static var previews: some View {
        let previewViewModel = PickerInputViewModel(labelText: "are you filing as joingt", selectedIndex: 0, options: ["yes", "no"])
        PickerInputView(viewModel: previewViewModel)
    }
}
