//
//  TertiaryTextStyle.swift
//  Statera
//
//  Created by Ian Hall on 12/28/23.
//

import SwiftUI

struct TertiaryTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Inter", size: 12))
            .foregroundColor(Color(red: 0.44, green: 0.44, blue: 0.44))
    }
}
