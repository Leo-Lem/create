// Created by Leopold Lemmermann on 29.05.23.

extension App {
  func templateActions() -> Set<Action> {
    let app = "apps/\(template.rawValue)"

    let root: String?

    switch template {
    case .simple: root = nil
    case .tca: root = "app"
    }

    return [.download(app), .stageAll(app, rename: root)]
  }
}
