//	Created by Leopold Lemmermann on 17.11.22.

import Foundation

extension URL {
  @_disfavoredOverload
  @available(macOS, obsoleted: 13)
  func appending(component: String) -> Self {
    appendingPathComponent(component)
  }

  @_disfavoredOverload
  @available(macOS, obsoleted: 13)
  mutating func append(component: String) {
    appendPathComponent(component)
  }

  @_disfavoredOverload
  @available(macOS, obsoleted: 13)
  func path() -> String {
    path
  }
}

extension String {
  @_disfavoredOverload
  @available(macOS, obsoleted: 13)
  func replacing(_ match: String, with replacement: String) -> String {
    replacingOccurrences(of: " ", with: "")
  }
}
