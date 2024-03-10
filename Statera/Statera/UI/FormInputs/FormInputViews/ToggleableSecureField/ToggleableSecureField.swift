//
//  ToggleableSecureField.swift
//  Statera
//
//  Created by Ian Hall on 1/22/24.
//

import SwiftUI

public struct ToggleableSecureField: View {
  @State private var isSecure: Bool

  private var title: String
  private var text: Binding<String>
  private var prompt: Text?

  public init(
    _ isSecure: Bool = true,
    title: String,
    text: Binding<String>,
    prompt: Text?
  ) {
    self.isSecure = isSecure
    self.title = title
    self.text = text
    self.prompt = prompt
  }
  
  public var body: some View {
    VStack {
      if isSecure {
        if #available(iOS 15.0, *) {
          SecureField(LocalizedStringKey(title), text: text, prompt: prompt)
                .ignoresSafeArea(.keyboard, edges: .bottom)
        } else {
          SecureField(LocalizedStringKey(title), text: text)
                .ignoresSafeArea(.keyboard, edges: .bottom)

        }
      } else {
        if #available(iOS 15.0, *) {
          TextField(LocalizedStringKey(title), text: text, prompt: prompt)
                .ignoresSafeArea(.keyboard, edges: .bottom)
        } else {
          TextField(LocalizedStringKey(title), text: text)
                .ignoresSafeArea(.keyboard, edges: .bottom)

        }
      }
    }
    .textFieldStyle(
      .toggleableSecureField(isSecure: $isSecure)
    )
  }
}
