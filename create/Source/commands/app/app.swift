// Created by Leopold Lemmermann on 26.05.23.

import ArgumentParser

struct App: CreateCommand {
  static let configuration = CommandConfiguration(abstract: "Creates a new app.")

  @OptionGroup var general: CreateCommandOptions

  @Flag(help: "The template to use.") var template: Kind = .simple

  @Option(name: .shortAndLong, help: "Your organisation name. (for Bundle identifier)")
  var organisation: String

  @Option(name: [.long, .customShort("i")], help: "Your team ID. (default: select manually in Xcode)")
  var teamId: String?

  @Flag(name: [.long, .customShort("l")], inversion: .prefixedNo, help: "Use SwiftLint.")
  var swiftlint = true

  func addActions(to actions: inout Set<Action>) {
    actions.formUnion(templateActions())

    if template == .tca { actions.formUnion(xcworkspace()) }

    actions.formUnion(xcodeproj(name: "app/app.xcodeproj"))
    
    actions.formUnion(xcscheme())

    if general.repo { actions.insert(.stageCopy(".gitignore", rename: "app/.gitignore")) }
    if swiftlint { actions.formUnion(swiftlintActions()) }

    // TODO: add feature package
  }
}

extension App {
  enum Kind: String, EnumerableFlag {
    case simple
    case tca
  }
}
