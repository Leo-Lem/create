// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser
import struct Foundation.URL

struct Package: CreateCommand {
  static let category = "package", configuration = CommandConfiguration(abstract: "Creates a new package.")

  @OptionGroup var location: LocationOption
  @OptionGroup var options: Options
  @OptionGroup var general: GeneralFlags

  var folders: [Template] {
    [
      .package,
      options.ci ? .githubCI : nil
    ].compactMap { $0 }
  }

  var files: [Template] {
    [
      general.readme ? .readme : nil,
      general.license ? .license : nil,
      general.repo ? .gitignore : nil
    ].compactMap { $0 }
  }

  var replacements: [Replacement] { [
    .title(location.title),
    .name(),
    .date,
    .year
  ] }

  func stage(from downloads: URL, to stage: URL) throws {
    try Files.moveAll(in: downloads.appending(component: Template.package.rawValue), to: stage)

    for f in files + folders.filter({ $0 != .package }) {
      try Files.move(from: downloads.appending(component: f.rawValue), to: stage.appending(component: f.rawValue))
    }
  }

  func run() {
    create(project: location.project, repo: general.repo, open: general.open)
  }
}

extension Package {
  struct Options: ParsableArguments {
    @Flag(name: .long, inversion: .prefixedNo, help: "Adds Github Actions CI config.") var ci = true
    @Option(name: .long, help: "The Swift tools version.") var swiftToolsVersion = "5.8"
    @Option(
      name: .long,
      parsing: .upToNextOption,
      help: "The supported platforms."
    ) var platforms = [".iOS(.v13)", ".macOS(.v10_15)"]
  }
}
