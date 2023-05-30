// Created by Leopold Lemmermann on 26.05.23.

import ArgumentParser

struct App: CreateCommand {
  static let configuration = CommandConfiguration(abstract: "Creates a new app.")

  @OptionGroup var general: BaseOptions

  @Flag(help: "The template to use.") var template: Kind = .simple

  @Option(name: .shortAndLong, help: "Your organisation name. (for Bundle identifier)")
  var organisation: String

  @Flag(name: .long, inversion: .prefixedNo, help: "Use SwiftLint.")
  var swiftlint = true

  @Option(name: .shortAndLong, help: "The name of your first feature.") var featureName = "Feature"

  func addActions(to actions: inout [Action]) {
    actions += Actions.template(template)
    actions += Actions.xcodeproj(name: "<#TITLE#>/<#TITLE#>", organisation: organisation)

    if template == .tca {
      actions += Actions.xcworkspace(general: general)
      actions += Actions.tca()
      actions += Actions.feature(featureName)
    }
    
    actions += Actions.xcscheme(for: template)

    if general.repo { actions += Actions.gitignore(at: "<#TITLE#>/.gitignore") }
    if swiftlint { actions += Actions.swiftlint() }
  }

  func runAfterSetup() throws {
    if template == .tca { addFeature() }
  }
}
