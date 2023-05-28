// Created by <#NAME#> on <#DATE#>.

import SwiftUI

struct HelloLabel: View {
  let name: String

  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)

      Text("HELLO \(name)")
    }
    .padding()
  }
}

// MARK: - (PREVIEWS)

#if DEBUG
  struct HelloLabel_Previews: PreviewProvider {
    static var previews: some View {
      HelloLabel(name: name)
    }
  }
#endif
