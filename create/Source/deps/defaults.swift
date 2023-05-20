// Created by Leopold Lemmermann on 20.05.23.

import Dependencies

struct Defaults {
  var platform: String
}

extension Defaults: DependencyKey {
  static let liveValue = Defaults(
    platform: ".iOS(.v13), .macOS(.v10_15)"
  )
}

extension DependencyValues {
  var defaults: Defaults {
    get { self[Defaults.self] }
    set { self[Defaults.self] = newValue }
  }
}
