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

  @Option(name: .shortAndLong, help: "The name of your first feature.")
  var featureName = "Feature"

  func addActions(to actions: inout [Action]) {
    actions += templateActions()
    actions += xcodeproj(name: "<#TITLE#>/<#TITLE#>")

    if template == .tca {
      actions += xcworkspace()
      actions += tcaActions()
      actions += featurePackage()
    }
    
    actions += xcscheme()

    if general.repo { actions += gitignore() }
    if swiftlint { actions += swiftlintActions() }
  }

  func runAfterSetup() throws {
    if template == .tca { addFeaturePackage() }
  }
}

extension App {
  enum Kind: String, EnumerableFlag {
    case simple
    case tca
  }
}
