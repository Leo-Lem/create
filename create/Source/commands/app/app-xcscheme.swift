// Created by Leopold Lemmermann on 29.05.23.

extension App {
  func xcscheme() -> Set<Action> {
    switch template {
    case .simple: return [] // TODO: implement simple
    case .tca:
      let unit = "app/test/Unit.xctestplan"
      let full = "app/test/Full.xctestplan"
      return Set([
        Action.testplan(name: "unit", path: unit),
        Action.testplan(name: "full", path: full),
        Action.xcscheme(
          at: "<#TITLE#>.xcworkspace/xcshareddata/xcschemes/<#TITLE#>.xcscheme",
          container: "app/app.xcodeproj",
          testPlans: [
            (path: unit, isDefault: true),
            (path: full, isDefault: false)
          ]
        )
      ].flatMap { $0 })
    }
  }
}
