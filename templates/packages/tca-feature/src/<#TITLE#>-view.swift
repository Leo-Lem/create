// Created by <#NAME#> on <#DATE#>.

import ComposableArchitecture
import SwiftUI

public struct <#TITLE#>View: View {
  @EnvironmentObject var store: StoreOf<<#TITLE#>>

  public var body: some View {
    WithViewStore(store) { vs in
      // TODO: configure <#TITLE#> view
      Render()
    }
  }

  public init() {}
}

extension Store: ObservableObject {}

// MARK: - (RENDER)

extension <#TITLE#>View {
  struct Render: View {
    var body: some View {
      Text("Hello, world!") // TODO: implement <#TITLE#> render view
    }
  }
}

// MARK: - (PREVIEWS)

#if DEBUG
  struct <#TITLE#>View_Previews: PreviewProvider {
    static var previews: some View {
      <#TITLE#>View.Render()
    }
  }
#endif
