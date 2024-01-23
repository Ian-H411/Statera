//
//  ToggleableSecureFieldExtensions.swift
//  Statera
//
//  Created by Ian Hall on 1/22/24.
//

import SwiftUI

extension EnvironmentValues {
  public var secureToggleImageShow: Image {
    get { self[SecureToggleImageShowKey.self] }
    set { self[SecureToggleImageShowKey.self] = newValue }
  }

  public var secureToggleImageHide: Image {
    get { self[SecureToggleImageHideKey.self] }
    set { self[SecureToggleImageHideKey.self] = newValue }
  }
  
  public var secureToggleImageTintColor: Color {
    get { self[SecureToggleImageTintKey.self] }
    set { self[SecureToggleImageTintKey.self] = newValue }
  }
}


private struct SecureToggleImageShowKey: EnvironmentKey {
  static let defaultValue = Image(systemName: "eye")
}

private struct SecureToggleImageHideKey: EnvironmentKey {
  static let defaultValue = Image(systemName: "eye.slash")
}

private struct SecureToggleImageTintKey: EnvironmentKey {
  static let defaultValue = Color.accentColor
}
