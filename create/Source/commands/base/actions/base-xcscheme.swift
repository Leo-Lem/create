// Created by Leopold Lemmermann on 29.05.23.

extension BaseActions {
  static func xcscheme(at path: String, container: String, testPlans: [(path: String, isDefault: Bool)]) -> [Action] {
    let file = "xcode/.xcscheme"

    return [
      .download(file),
      .stage(file, rename: "\(path).xcscheme"),
      .replace("<#SCHEME_CONTAINER#>", replacement: container),
      .replace("<#SCHEME_TESTPLANS#>", replacement: testPlans
          .map { planPath, isDefault in
            "<TestPlanReference "
              + "reference = \"container:\(planPath).xctestplan\" \(isDefault ? "default = \"YES\"" : "")>"
              + "</TestPlanReference>"
          }
          .joined(separator: "\n"))
    ]
  }
}
