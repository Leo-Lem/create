// Created by Leopold Lemmermann on 29.05.23.

extension Action {
  static func testplan(name: String, path: String) -> Set<Self> {
    var actions = Set<Self>()
    let file = "testplans/\(name).xctestplan"
    actions.insert(.download(file))
    actions.insert(.stage(file, rename: path))
    return actions
  }

  static func xcscheme(at path: String, container: String, testPlans: [(path: String, isDefault: Bool)]) -> Set<Self> {
    var actions = Set<Self>()
    let file = "xcode/.xcscheme"
    actions.insert(.download(file))
    actions.insert(.stage(file, rename: path))
    actions.insert(.replace("<#SCHEME_CONTAINER#>", replacement: container))
    actions.insert(.replace("<#SCHEME_TESTPLANS#>", replacement: testPlans
        .map { planPath, isDefault in
          "<TestPlanReference "
            + "reference = \"container:\(planPath)\" \(isDefault ? "default = \"YES\"" : "")>"
            + "</TestPlanReference>"
        }
        .joined(separator: "\n")))

    return actions
  }

  static func xcworkspace(at path: String, fileRefs: [String]) -> Set<Self> {
    let file = "xcode/.xcworkspace"
    return [
      .download(file),
      .stage(file, rename: path),
      .replace("<#WORKSPACE_FILE_REFS#>", replacement: fileRefs.map {
        "<FileRef location = \"group:\($0)\"></FileRef>"
      }
      .joined(separator: "\n"))
    ]
  }
}
