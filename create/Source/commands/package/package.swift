// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser

struct Package: CreateCommand {
  static let configuration = CommandConfiguration(abstract: "Creates a new package.")

  @OptionGroup var general: CreateCommandOptions

  @Flag(help: "The template to use.")
  var template: Kind = .plain

  @Flag(name: .long, inversion: .prefixedNo, help: "Adds Github Actions CI config.")
  var ci = true

  @Option(name: .long, help: "The Swift tools version.")
  var swiftToolsVersion = "5.8"

  @Option(name: .long, parsing: .upToNextOption, help: "The supported platforms.")
  var platforms = [".iOS(.v13)", ".macOS(.v10_15)"]
}

extension Package {
  enum Kind: String, EnumerableFlag {
    case plain
    case tcaFeature
  }
}
