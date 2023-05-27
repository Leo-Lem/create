// Created by <#NAME#> on <#DATE#>.

import ComposableArchitecture
import SwiftUI

struct AppView: View {
  @EnvironmentObject private var store: StoreOf<AppReducer>

  var body: some View {
    WithViewStore(store, observe: \.isActive, send: /AppReducer.Action.toggleIsActive) { isActive in
      Render(isActive: isActive.state) { isActive.send(.toggleIsActive) }
    }
  }
}

// MARK: - (RENDER)

extension AppView {
  struct Render: View {
    let isActive: Bool
    let toggleIsActive = () -> Void

    var body: some View {
      if isActive {
        HelloView()
      } else {
        Button("Tap to active", action: toggleIsActive)
      }
    }
  }
}

// MARK: - (PREVIEWS)

#if DEBUG
  struct AppView_Previews: PreviewProvider {
    static var previews: some View {
      AppView.Render(isActive: true) {}
        .previewDisplayName("Active")

      AppView.Render(isActive: false) {}
        .previewDisplayName("Inactive")
    }
  }
#endif
