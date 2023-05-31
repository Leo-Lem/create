// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser

struct Package: CreateCommand {
  static let configuration = CommandConfiguration(abstract: "Creates a new package.")

  @OptionGroup var location: LocationOptions

  @Flag(help: "The template to use.") var template: Kind

  @OptionGroup var general: BaseOptions

  @Flag(name: .long, inversion: .prefixedNo, help: "Adds Github Actions CI config.") var ci = true

  func addActions(to actions: inout [Action]) {
    actions += Actions.template(template)
    actions += Actions.xcscheme()
    if ci { actions += Actions.ci() }
  }
}


extension Package {
  init(location: LocationOptions, template: Kind, general: BaseOptions, ci: Bool) {
    self.location = location
    self.template = template
    self.general = general
    self.ci = ci
  }
}
