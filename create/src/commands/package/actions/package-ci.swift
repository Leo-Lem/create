// Created by Leopold Lemmermann on 31.05.23.

extension Package.Actions {
  static func ci() -> [Action] {
    let ci = "ci/github-actions.yml"
    
    return [.download(ci), .stage(ci, rename: ".github/workflows/ci.yml")]
  }
}
