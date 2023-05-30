// Created by Leopold Lemmermann on 29.05.23.

extension App.Actions {
  static func template(_ template: App.Kind) -> [Action] {
    let app = "apps/\(template.rawValue)"

    let root: String?

    switch template {
    case .simple: root = nil
    case .tca: root = "<#TITLE#>"
    }

    return [.download(app), .stageAll(app, rename: root)]
  }
}
