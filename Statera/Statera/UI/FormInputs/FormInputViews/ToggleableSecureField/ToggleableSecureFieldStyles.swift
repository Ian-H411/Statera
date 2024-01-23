//
//  ToggleableSecureFieldStyles.swift
//  Statera
//
//  Created by Ian Hall on 1/22/24.
//

import SwiftUI

struct ToggleableSecureFieldStyle: TextFieldStyle {
  @Environment(\.secureToggleImageShow) private var imageOn
  @Environment(\.secureToggleImageHide) private var imageOff
  @Environment(\.secureToggleImageTintColor) private var tint

  @Binding var isSecure: Bool

  init(isSecure: Binding<Bool>) {
    self._isSecure = isSecure
  }
  
  func _body(configuration: TextField<_Label>) -> some View {
    TextField("", text: .constant(""))
      .overlay(
        configuration
          .overlay(
            HStack {
              Spacer()
              Button(
                action: { isSecure.toggle() },
                label: {
                  Group {
                    isSecure ? imageOn : imageOff
                  }
                  .tintColor(tint)
                }
              )
              .padding(.trailing, 8)
              .padding(.vertical, 4)
            }
          )
      )
  }
}

extension View {
  @ViewBuilder
  func tintColor(_ color: Color) -> some View {
    if #available(iOS 15.0, *) {
      self.tint(color)
    } else {
      self.foregroundColor(color)
    }
  }
}

#if compiler(>=5.5)

extension TextFieldStyle where Self == ToggleableSecureFieldStyle {
  static func toggleableSecureField(isSecure: Binding<Bool>) -> Self {
    return ToggleableSecureFieldStyle(isSecure: isSecure)
  }
}

#endif
  
