// Created by Leopold Lemmermann on 31.05.23.

extension Package.Actions {
  static func template(_ kind: Package.Kind) -> [Action] {
    [
      .download("packages/\(kind.rawValue)"),
      .stageAll("packages/\(kind.rawValue)")
    ]
  }
}
