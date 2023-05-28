// Created by Leopold Lemmermann on 28.05.23.

extension Replacement {
  static func swiftToolsVersion(_ version: String) -> Self { .replacement("<#SWIFT_TOOLS_VERSION#>", version) }
  static func platforms(_ platforms: [String]) -> Self { .replacement("<#PLATFORMS#>", platforms.joined(separator: ", ")) }
}
