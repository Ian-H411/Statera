//
//  PrimaryButton.swift
//  Statera
//
//  Created by Ian Hall on 11/10/23.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    @State var enabled: Bool = true
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.leading, 12)
            .padding(.trailing, 11)
            .padding(.top, 10)
            .padding(.bottom, 9)
            .frame(width: 170, height: 37, alignment: .center)
            .background(
                EllipticalGradient(
                    stops: [
                        Gradient.Stop(color: enabled ? Color(red: 0.05, green: 0.29, blue: 1) : Color.gray, location: 0.34),
                        Gradient.Stop(color: enabled ? Color(red: 0.05, green: 0.29, blue: 1).opacity(0.8) : Color.gray.opacity(0.8), location: 1.00),
                    ],
                    center: UnitPoint(x: 0.5, y: 0.51)
                )
            )
            .cornerRadius(6)
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
    }
}
