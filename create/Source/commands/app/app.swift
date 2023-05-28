// Created by Leopold Lemmermann on 26.05.23.

import ArgumentParser
import struct Foundation.URL

struct App: CreateCommand {
  static let configuration = CommandConfiguration(abstract: "Creates a new app.")

  @OptionGroup var general: CreateCommandOptions

  @Option(name: .shortAndLong, help: "Your organisation name. (for Bundle identifier)")
  var organisation: String

  @Option(name: [.long, .customShort("i")], help: "Your team ID. (default: select manually in Xcode)")
  var teamID: String?

  @Flag(name: [.long, .customShort("l")], inversion: .prefixedNo, help: "Use SwiftLint.")
  var swiftlint = true

  @Flag(name: .long, inversion: .prefixedNo, help: "Use the composable architecture.")
  var tca = true

  func add(templates: inout [Template]) throws {
    templates = [.app, .xcworkspace, .xcproject, .res]
    if swiftlint { templates.append(.swiftlint) }
  }

  func stage(from downloads: URL, to stage: URL) throws {
    try Template.app.move(from: downloads, to: stage)
    try Template.xcworkspace.move(from: downloads, to: stage, rename: "<#TITLE#>.xcworkspace")
    try Template.xcproject.move(
      from: downloads, to: stage.appending(component: Template.app.name), rename: "app.xcodeproj"
    )
    try Template.res.move(from: downloads, to: stage)

    if general.repo {
      try Template.gitignore.copy(from: downloads, to: stage.appending(component: Template.app.name) )
    }

    if swiftlint {
      try Template.swiftlint.move(from: downloads, to: stage.appending(component: Template.app.name))
    }
  }

  func add(replacements: inout [Replacement]) throws {
    replacements.append(contentsOf: [.organisation(organisation), .teamId(teamID)])
    replacements.append(xcworkspace)
    replacements.append(contentsOf: xcodeproj)
  }
}
