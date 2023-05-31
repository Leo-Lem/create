// Created by Leopold Lemmermann on 31.05.23.

extension BaseActions {
  static func readme() -> [Action] {
    let readme = "README.md"
    return [.download(readme), .stage(readme)]
  }
}
