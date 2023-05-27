// Created by Leopold Lemmermann on 27.05.23.

import struct Foundation.URL

extension App {
  var folders: [Template] { [.app, .workspace] }

  var files: [Template] {
    [
      general.readme ? .readme : nil,
      general.license ? .license : nil,
      general.repo ? .gitignore : nil,
      .swiftlint
    ].compactMap { $0 }
  }

  func stage(from downloads: URL, to stage: URL) throws {
    try Template.app.move(from: downloads, to: stage)
    try Template.workspace.move(from: downloads, to: stage, rename: "<#TITLE#>.xcworkspace")

    if general.readme { try Template.readme.move(from: downloads, to: stage) }
    if general.license { try Template.license.move(from: downloads, to: stage) }
    if general.repo { try Template.gitignore.move(from: downloads, to: stage) }

    if options.swiftlint { try stageSwiftlint(from: downloads, to: stage) }
  }
}

private extension App {
  func stageSwiftlint(from downloads: URL, to stage: URL) throws {
    try Template.swiftlint.move(from: downloads, to: stage.appending(component: Template.app.rawValue))

    // TODO: add script conditionally to build phases
  }
}
