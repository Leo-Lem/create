// Created by Leopold Lemmermann on 31.05.23.

extension Package.Actions {
  static func xcscheme() -> [Action] {
    let testplan = "test/ <#TITLE#>"

    return BaseActions.testplan(path: testplan, targets: [("<#TITLE#>Tests", "", true)], coverageTargets: [("<#TITLE#>", "")])
      + BaseActions.xcscheme(
        at: ".swiftpm/xcode/xcshareddata/xcschemes/<#TITLE#>", container: "", testPlans: [(path: testplan, isDefault: true)]
      )
  }
}
