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
    .year,
    .swiftToolsVersion(options.swiftToolsVersion),
    .platforms(options.platforms)
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
