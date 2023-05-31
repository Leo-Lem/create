// Created by Leopold Lemmermann on 29.05.23.

extension App.Actions {
  static func template(_ template: App.Kind) -> [Action] {
    let app = "apps/\(template.rawValue)", config = "apps/shared/config", res = "apps/shared/res"

    let root: String?

    switch template {
    case .simple: root = nil
    case .tca: root = "<#TITLE#>"
    }

    return [
      .download(app), .stageAll(app, rename: root),
      .download(config), .stage(config, rename: (root.flatMap { $0 + "/" } ?? "") + config),
      .download(res), .stage(res, rename: (root.flatMap { $0 + "/" } ?? "") + res)
    ]
  }
}
