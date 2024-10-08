//
//  measure.swift
//  winston
//
//  Created by Igor Marcossi on 17/07/23.
//

import Foundation
import SwiftUI

extension View {
    func measureOnce(_ sizeBinding: Binding<CGSize?>) -> some View {
        self
        .background(
          sizeBinding.wrappedValue != nil ?
          nil :
          GeometryReader { geometry in
            Color.clear
              .preference(key: ViewSizeKey.self, value: geometry.size)
          }
        )
        .onPreferenceChange(ViewSizeKey.self) { size in
          if sizeBinding.wrappedValue == nil {
            sizeBinding.wrappedValue = size
          }
        }
    }
    func measure(_ sizeBinding: Binding<CGSize>) -> some View {
        self
        .background(
          GeometryReader { geometry in
            Color.clear
              .preference(key: ViewSizeKey.self, value: geometry.size)
          }
        )
        .onPreferenceChange(ViewSizeKey.self) { size in
          sizeBinding.wrappedValue = size
        }
    }
}

struct ViewSizeKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = value + nextValue()
  }
}
