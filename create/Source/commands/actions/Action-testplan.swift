// Created by Leopold Lemmermann on 29.05.23.

extension Action {
  static func testplan(name: String, path: String) -> Set<Self> {
    var actions = Set<Self>()
    let file = "testplans/\(name).xctestplan"
    actions.insert(.download(file))
    actions.insert(.stage(file, rename: path))
    return actions
  }
}
