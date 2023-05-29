// Created by Leopold Lemmermann on 29.05.23.

extension App {
  func templateActions() -> Set<Action> {
    let app = "apps/\(template.rawValue)"

    let src: String
    switch template {
    case .simple: src = "src"
    case .tca: src = "app/src"
    }

    return [.download(app), .stageAll(app, rename: src)]
  }
}
