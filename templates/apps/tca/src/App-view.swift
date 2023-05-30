// Created by <#NAME#> on <#DATE#>.

import ComposableArchitecture
import SwiftUI
import struct <#FEATURE_TITLE#>.<#FEATURE_TITLE#>View

struct AppView: View {
  @EnvironmentObject private var store: StoreOf<AppReducer>

  var body: some View {
    WithViewStore(store) { vs in
      Render()
        .environmentObject(store.scope(state: \.<#FEATURE_VARIABLE#>, action: { .<#FEATURE_VARIABLE#>($0) }))
    }
  }
}

// MARK: - (RENDER)

extension AppView {
  struct Render: View {
    var body: some View {
      <#FEATURE_TITLE#>View()
    }
  }
}

// MARK: - (PREVIEWS)

#if DEBUG
  struct AppView_Previews: PreviewProvider {
    static var previews: some View {
      AppView.Render()
    }
  }
#endif
