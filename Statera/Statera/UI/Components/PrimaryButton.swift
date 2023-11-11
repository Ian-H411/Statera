//
//  PrimaryButton.swift
//  Statera
//
//  Created by Ian Hall on 11/10/23.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .cornerRadius(8)
            .foregroundColor(.white)
            .background(configuration.isPressed ? Color.gray : Color.blue)
    }
}
