// Created by Leopold Lemmermann on 28.05.23.

extension Replacement {
  static func xcscheme(container: String, plans: [TestPlan]) -> Replacement {
    let container = Replacement.replacement("<#SCHEME_CONTAINER#>", container)
    let testplans = Replacement.replacement("<#SCHEME_TESTPLANS#>", plans.map(\.description).joined(separator: "\n"))

    return .replacements([container, testplans])
  }
}

struct TestPlan {
  let path: String
  let isDefault: Bool

  var description: String {
    "<TestPlanReference "
      + "reference = \"container:\(path)\" \(isDefault ? "default = \"YES\"" : "")>"
      + "</TestPlanReference>"
  }
}
