// Created by Leopold Lemmermann on 29.05.23.

extension App {
  func xcodeproj() -> Set<Action> {
    var actions = Set<Action>()

    switch template {
    case .simple: break // TODO: implement simple
    case .tca:
      
    }

    return actions.formUnion([
      .replace("<#ORGANISATION#>", replacement: organisation),
      .replace("<#TEAM_ID#>", replacement: teamId ?? "YOUR_TEAM_ID")
    ])
  }
}
