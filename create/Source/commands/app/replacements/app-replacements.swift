// Created by Leopold Lemmermann on 28.05.23.

extension Replacement {
  static func organisation(_ organisation: String) -> Self { .replacement("<#ORGANISATION#>", organisation) }
  static func teamId(_ id: String?) -> Self { .replacement("<#TEAM_ID#>", id ?? "YOUR_TEAM_ID_HERE") }
}
