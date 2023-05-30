// Created by <#NAME#> on <#DATE#>.

import class ComposableArchitecture.Store
import SwiftUI

@main
struct App: SwiftUI.App {
  var body: some Scene {
    WindowGroup {
      AppView()
        .environmentObject(store)
    }
  }

  private let store = Store(initialState: .init(), reducer: AppReducer.init)
}

extension Store: ObservableObject {} // pass store as environment object
