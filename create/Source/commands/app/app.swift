// Created by Leopold Lemmermann on 26.05.23.

import ArgumentParser
import struct Foundation.URL

struct App: CreateCommand {
  static let configuration = CommandConfiguration(abstract: "Creates a new app.")

  @OptionGroup var general: CreateCommandOptions

  @Flag(help: "The template to use.")
  var template: Kind = .default

  @Option(name: .shortAndLong, help: "Your organisation name. (for Bundle identifier)")
  var organisation: String

  @Option(name: [.long, .customShort("i")], help: "Your team ID. (default: select manually in Xcode)")
  var teamID: String?

  @Flag(name: [.long, .customShort("l")], inversion: .prefixedNo, help: "Use SwiftLint.")
  var swiftlint = true

  func add(templates: inout [Template]) throws {
    templates = [.app(template), .xcworkspace, .xcproject]
    if swiftlint { templates.append(.swiftlint) }
  }

  func stage(from downloads: URL, to stage: URL) throws {
    try Template.app(template).move(from: downloads, to: stage)
    try Template.xcworkspace.move(from: downloads, to: stage, rename: "<#TITLE#>.xcworkspace")
    try Template.xcproject.move(
      from: downloads, to: stage.appending(component: Template.app(template).path), rename: "app.xcodeproj"
    )

    if general.repo {
      try Template.gitignore.copy(from: downloads, to: stage.appending(component: Template.app(template).path))
    }

    if swiftlint {
      try Template.swiftlint.move(from: downloads, to: stage.appending(component: Template.app(template).path))
    }
  }

  func add(replacements: inout [Replacement]) throws {
    replacements.append(.organisation(organisation))
    replacements.append(.teamId(teamID))
    replacements.append(.xcworkspace(general))
    replacements += .xcscheme(template)

    switch template {
    case .default: break
    case .simple: break
    case .tca: replacements += .xcodeprojTCA(general, swiftlint: swiftlint)
    }
  }
}

extension App {
  enum Kind: String, EnumerableFlag {
    case `default`
    case simple
    case tca
  }
}
