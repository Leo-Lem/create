// Created by <#NAME#> on <#DATE#>.

import SwiftUI

struct AppView: View {
  var body: some View {
    Render() // TODO: configure AppView
  }
}

// MARK: - (RENDER)

extension AppView {
  struct Render: View {
    var body: some View {
      Text("Hello, world!") // TODO: design AppView
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
