// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser
import struct Foundation.URL

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

  func add(templates: inout [Template]) throws {
    templates.append(.package(template))
    if ci { templates.append(.githubCI) }
  }

  func stage(from downloads: URL, to stage: URL) throws {
    try Template.package(template).moveAll(from: downloads, into: stage)
    if ci { try Template.githubCI.move(from: downloads, to: stage) }
  }

  func add(replacements: inout [Replacement]) throws {
    replacements.append(.swiftToolsVersion(swiftToolsVersion))
    replacements.append(.platforms(platforms))
  }
}

extension Package {
  enum Kind: String, EnumerableFlag {
    case plain
    case tcaFeature
  }
}
