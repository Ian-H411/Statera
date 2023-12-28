//
//  SecondaryButton.swift
//  Statera
//
//  Created by Ian Hall on 11/10/23.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .cornerRadius(8)
            .font(.system(size: 12))
            .foregroundColor(.gray)
            .background(configuration.isPressed ? Color.gray : Color.white)
    }
}
