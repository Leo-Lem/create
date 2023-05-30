// Created by Leopold Lemmermann on 29.05.23.

extension Action {
  // TODO: make test plans completely configurable
  static func testplan(name: String, path: String) -> [Self] {
    var actions = [Self]()
    let file = "testplans/\(name).xctestplan"
    actions.append(.download(file))
    actions.append(.stage(file, rename: path))
    return actions
  }
}
