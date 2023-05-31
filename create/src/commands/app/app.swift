// Created by Leopold Lemmermann on 26.05.23.

import ArgumentParser

struct App: CreateCommand {
  static let configuration = CommandConfiguration(abstract: "Creates a new app.")

  @Flag(help: "The template to use.") var template: Kind

  @OptionGroup var location: LocationOptions

  @Option(name: .shortAndLong, help: "Your organisation name. (for Bundle identifier)") var org: String

  @Option(name: .shortAndLong, help: "The name of your first feature.") var feature = "Feature"

  @OptionGroup var general: BaseOptions

  @Flag(name: .long, inversion: .prefixedNo, help: "Use SwiftLint.") var swiftlint = true

  func addActions(to actions: inout [Action]) {
    actions += Actions.template(template)
    actions += Actions.xcodeproj(for: template, organisation: org)

    if template == .tca {
      actions += Actions.xcworkspace(general: general)
      actions += Actions.tca()
      actions += Actions.feature(feature)
    }
    
    actions += Actions.xcscheme(for: template)

    if general.repo { actions += Actions.gitignore(at: template == .tca ? "<#TITLE#>/.gitignore" : nil) }
    if swiftlint { actions += Actions.swiftlint(at: template == .tca ? "<#TITLE#>/.swiftlint.yml" : nil) }
  }

  func runAfterSetup() throws {
    if template == .tca { addFeature() }
  }
}
