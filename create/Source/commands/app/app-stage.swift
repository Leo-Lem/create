// Created by Leopold Lemmermann on 27.05.23.

import struct Foundation.URL
import struct Foundation.UUID

extension App {
  var folders: [Template] { [.app, .xcworkspace, .xcproject, .res] }

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
    try Template.xcworkspace.move(from: downloads, to: stage, rename: "<#TITLE#>.xcworkspace")
    try Template.xcproject.move(
      from: downloads, to: stage.appending(component: Template.app.rawValue), rename: "app.xcodeproj"
    )
    try Template.res.move(from: downloads, to: stage)

    if general.readme { try Template.readme.move(from: downloads, to: stage) }
    if general.license { try Template.license.move(from: downloads, to: stage) }
    if general.repo {
      try Template.gitignore.copy(from: downloads, to: stage.appending(component: Template.app.rawValue) )
      try Template.gitignore.move(from: downloads, to: stage)
    }

    if options.swiftlint {
      try Template.swiftlint.move(from: downloads, to: stage.appending(component: Template.app.rawValue))
    }
  }
}
