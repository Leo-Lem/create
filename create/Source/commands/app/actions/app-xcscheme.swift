// Created by Leopold Lemmermann on 29.05.23.

extension App.Actions {
  static func xcscheme(for kind: App.Kind) -> [Action] {
    switch kind {
    case .simple:
      let unit = "test/Unit"
      let full = "test/Full"

      return BaseActions.testplan(
        path: unit,
        targets: [("<#TITLE#>Tests", "<#SCHEME_CONTAINER#>", true)],
        coverageTargets: [("<#TITLE#>", "<#SCHEME_CONTAINER#>")]
      )
      + BaseActions.testplan(
        path: full,
        targets: [("<#TITLE#>Tests", "<#SCHEME_CONTAINER#>", true), ("<#TITLE#>UITests", "<#SCHEME_CONTAINER#>", false)],
        coverageTargets: [("<#TITLE#>", "<#SCHEME_CONTAINER#>")]
      )
      + BaseActions.xcscheme(
          at: "<#TITLE#>.xcodeproj/xcshareddata/xcschemes/<#TITLE#>",
          container: "<#TITLE#>.xcodeproj",
          testPlans: [
            (path: unit, isDefault: true),
            (path: full, isDefault: false)
          ]
        )
    case .tca:
      let unit = "<#TITLE#>/test/Unit"
      let full = "<#TITLE#>/test/Full"

      return BaseActions.testplan(
        path: unit,
        targets: [("<#TITLE#>Tests", "<#SCHEME_CONTAINER#>", true)],
        coverageTargets: [("<#TITLE#>", "<#SCHEME_CONTAINER#>")]
      )
      + BaseActions.testplan(
        path: full,
        targets: [("<#TITLE#>Tests", "<#SCHEME_CONTAINER#>", true), ("<#TITLE#>UITests", "<#SCHEME_CONTAINER#>", false)],
        coverageTargets: [("<#TITLE#>", "<#SCHEME_CONTAINER#>")]
      )
      + BaseActions.xcscheme(
          at: "<#TITLE#>.xcworkspace/xcshareddata/xcschemes/<#TITLE#>",
          container: "<#TITLE#>/<#TITLE#>.xcodeproj",
          testPlans: [
            (path: unit, isDefault: true),
            (path: full, isDefault: false)
          ]
        )
    }
  }
}
