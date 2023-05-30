// Created by Leopold Lemmermann on 29.05.23.

extension Action {
  static func xcscheme(at path: String, container: String, testPlans: [(path: String, isDefault: Bool)]) -> [Self] {
    var actions = [Self]()
    let file = "xcode/.xcscheme"
    actions.append(.download(file))
    actions.append(.stage(file, rename: path))
    actions.append(.replace("<#SCHEME_CONTAINER#>", replacement: container))
    actions.append(.replace("<#SCHEME_TESTPLANS#>", replacement: testPlans
        .map { planPath, isDefault in
          "<TestPlanReference "
            + "reference = \"container:\(planPath)\" \(isDefault ? "default = \"YES\"" : "")>"
            + "</TestPlanReference>"
        }
        .joined(separator: "\n")))

    return actions
  }
}
