// Created by Leopold Lemmermann on 28.05.23.

extension Package {
  func add(replacements: inout [Replacement]) throws {
    replacements.append(.swiftToolsVersion(swiftToolsVersion))
    replacements.append(.platforms(platforms))
    replacements += .xcscheme()
  }
}

extension Replacement {
  static func swiftToolsVersion(_ version: String) -> Self { .replacement("<#SWIFT_TOOLS_VERSION#>", version) }

  static func platforms(_ platforms: [String]) -> Self { .replacement("<#PLATFORMS#>", platforms.joined(separator: ", ")) }
}

extension Array where Element == Replacement {
  static func xcscheme() -> Self {
    .xcscheme(container: "", plans: [.init(path: "test/ <#TITLE#>.xctestplan", isDefault: true)])
  }
}
