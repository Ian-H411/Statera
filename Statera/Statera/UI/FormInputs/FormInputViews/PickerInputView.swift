//
//  PickerInputView.swift
//  Statera
//
//  Created by Ian Hall on 11/4/23.
//

import SwiftUI

struct PickerInputView: View {
    //TODO:- Change to Binding
    @State var text: String = ""
    var displayLabel: String
    var options: [String]
    @State var selectedOptionIndex: Int = 0
    
    var body: some View {
        VStack {
            Text(displayLabel)
                .alignmentGuide(.leading) { _ in 0 }
                .frame(maxWidth: .infinity, alignment: .leading)
                .transition(AnyTransition.opacity.animation(.smooth(duration: 0.2)))
                .foregroundColor(.gray)
            Picker(displayLabel, selection: $selectedOptionIndex) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)
            .alignmentGuide(.leading) { _ in 0 }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


struct PickerInputView_Previews: PreviewProvider {
    static var previews: some View {
        PickerInputView(displayLabel: "Do you like Cake?", options: ["yes", "no", "maybe", "idk"], selectedOptionIndex: 0)
    }
}
