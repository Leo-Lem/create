// Created by Leopold Lemmermann on 28.05.23.

extension Replacement {
  static func organisation(_ organisation: String) -> Self { .replacement("<#ORGANISATION#>", organisation) }
  static func teamId(_ id: String?) -> Self { .replacement("<#TEAM_ID#>", id ?? "YOUR_TEAM_ID_HERE") }
}

extension Array where Element == Replacement {
  static func xcscheme(_ kind: App.Kind) -> Self {
    switch kind {
    case .default:
      fatalError("Unimplemented")
    case .simple:
      fatalError("Unimplemented")
    case .tca:
      return .xcscheme(container: "app/app.xcodeproj", plans: [
        .init(path: "app/test/Unit.xctestplan", isDefault: true),
        .init(path: "app/test/Full.xctestplan")
      ])
    }
  }
}
