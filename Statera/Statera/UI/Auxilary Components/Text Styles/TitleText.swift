//
//  TitleText.swift
//  Statera
//
//  Created by Ian Hall on 12/28/23.
//

import SwiftUI

struct TitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(
                Font.custom("Inter", size: 30)
                    .weight(.bold)
            )
    }
}
