// Created by Leopold Lemmermann on 29.05.23.

extension App {
  func xcscheme() -> [Action] {
    switch template {
    case .simple: return [] // TODO: implement simple
    case .tca:
      let unit = "<#TITLE#>/test/Unit"
      let full = "<#TITLE#>/test/Full"

      return Action.testplan(path: unit, targets: [("<#TITLE#>Tests", true)], coverageTargets: ["<#TITLE#>"])
      + Action.testplan(
        path: full, targets: [("<#TITLE#>Tests", true), ("<#TITLE#>UITests", false)], coverageTargets: ["<#TITLE#>"]
      )
      + Action.xcscheme(
          at: "<#TITLE#>.xcworkspace/xcshareddata/xcschemes/<#TITLE#>.xcscheme",
          container: "<#TITLE#>/<#TITLE#>.xcodeproj",
          testPlans: [
            (path: unit, isDefault: true),
            (path: full, isDefault: false)
          ]
        )
    }
  }

  func buildActionEntry(name: String, path: String) -> String {
    return "<BuildActionEntry "
      + "buildForTesting = \"YES\" "
      + "buildForRunning = \"YES\" "
      + "buildForProfiling = \"YES\" "
      + "buildForArchiving = \"YES\" "
      + "buildForAnalyzing = \"YES\"> "
      + "<BuildableReference "
      + "BuildableIdentifier = \"primary\" "
      + "BlueprintIdentifier = \"\(name)\" "
      + "BuildableName = \"\(name)\" "
      + "BlueprintName = \"\(name)\" "
      + "ReferencedContainer = \"container:\(path)\">"
      + "</BuildableReference>"
      + "</BuildActionEntry>"
  }
}
