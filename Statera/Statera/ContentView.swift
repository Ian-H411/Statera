//
//  ContentView.swift
//  Statera
//
//  Created by Ian Hall on 10/29/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            PickerInputView(displayLabel: "do you like cake", options: ["yes", "no", "maybe"], selectedOptionIndex: 0)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
