//
//  GrayedButton.swift
//  Statera
//
//  Created by Ian Hall on 12/28/23.
//

import SwiftUI

struct GrayedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 170, height: 37, alignment: .center)
            .padding(.leading, 13)
            .padding(.trailing, 14)
            .padding(.top, 9)
            .padding(.bottom, 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(
                        EllipticalGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 0.44, green: 0.44, blue: 0.44), location: 0.51),
                                Gradient.Stop(color: Color(red: 0.44, green: 0.44, blue: 0.44).opacity(0.8), location: 1.00),
                            ],
                            center: UnitPoint(x: 0.5, y: 0.51)
                        )
                    )
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
