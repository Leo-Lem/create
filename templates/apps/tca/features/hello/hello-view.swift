// Created by <#NAME#> on <#DATE#>.

import ComposableArchitecture
import SwiftUI

struct HelloView: View {
  @EnvironmentObject private var store: StoreOf<AppReducer>

  var body: some View {
    WithViewStore(store, observe: \.hello, send: /AppReducer.Action.hello) { hello in
      Render(isActive: hello.name)
    }
  }
}

// MARK: - (RENDER)

extension HelloView {
  struct Render: View {
    let name: String
    let setNameToWorld: () -> Void

    var body: some View {
      HelloLabel(name: name)
        .onTapGesture(perform: setNameToWorld)
    }
  }
}

// MARK: - (PREVIEWS)

#if DEBUG
  struct HelloView_Previews: PreviewProvider {
    @ViewBuilder
    static var previews: some View {
      HelloView.Render(path: "<#NAME#>") {}
    }
  }
#endif
