// Created by Leopold Lemmermann on 29.05.23.

extension Action {
  static func xcscheme(at path: String, container: String, testPlans: [(path: String, isDefault: Bool)]) -> [Action] {
    let file = "xcode/.xcscheme"

    return [
      .download(file),
      .stage(file, rename: path),
      .replace("<#SCHEME_CONTAINER#>", replacement: container),
      .replace("<#SCHEME_TESTPLANS#>", replacement: testPlans
          .map { planPath, isDefault in
            "<TestPlanReference "
              + "reference = \"container:\(planPath)\" \(isDefault ? "default = \"YES\"" : "")>"
              + "</TestPlanReference>"
          }
          .joined(separator: "\n"))
    ]
  }
}
