// Created by Leopold Lemmermann on 28.05.23.

extension Array where Element == Replacement {
  static func xcscheme(container: String, plans: [TestPlan]) -> Self {
    let container = Replacement.replacement("<#SCHEME_CONTAINER#>", container)
    let testplans = Replacement.replacement("<#SCHEME_TESTPLANS#>", plans.map(\.description).joined(separator: "\n"))

    return [container, testplans]
  }
}

struct TestPlan {
  let path: String
  let isDefault: Bool

  init(path: String, isDefault: Bool = false) {
    self.path = path
    self.isDefault = isDefault
  }

  var description: String {
    "<TestPlanReference "
      + "reference = \"container:\(path)\" \(isDefault ? "default = \"YES\"" : "")>"
      + "</TestPlanReference>"
  }
}
