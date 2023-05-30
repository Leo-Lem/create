// Created by Leopold Lemmermann on 29.05.23.

extension App {
  func xcworkspace() -> [Action] {
    Action.xcworkspace(
      at: "<#TITLE#>.xcworkspace",
      fileRefs: [
        general.repo ? ".gitignore" : nil,
        general.readme ? "README.md" : nil,
        general.license ? "LICENSE" : nil,
        "app/app.xcodeproj"
      ]
      .compactMap { $0 }
    )
  }
}
