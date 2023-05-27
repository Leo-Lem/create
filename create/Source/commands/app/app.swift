// Created by Leopold Lemmermann on 26.05.23.

import ArgumentParser
import struct Foundation.URL

struct App: CreateCommand {
  static let category = "app", configuration = CommandConfiguration(abstract: "Creates a new app.")

  @OptionGroup var location: LocationOption
  @OptionGroup var options: Options
  @OptionGroup var general: GeneralFlags

  var folders: [Template] { [.app] }

  var files: [Template] {
    [
      general.readme ? .readme : nil,
      general.license ? .license : nil,
      general.repo ? .gitignore : nil,
      .swiftlint
    ].compactMap { $0 }
  }

  var replacements: [Replacement] { [
    .title(location.title),
    .name(),
    .date,
    .year,
    .organisation(options.organisation),
    .teamId(options.teamID),
    workspace
  ] }

  func run() {
    create(project: location.project, repo: general.repo, open: general.open)
  }
}

extension App {
  struct Options: ParsableArguments {
    @Option(name: .shortAndLong, help: "Your organisation name. (for Bundle identifier)")
    var organisation: String

    @Option(name: [.long, .customShort("i")], help: "Your team ID. (default: select manually in Xcode)")
    var teamID: String?

    @Flag(name: [.long, .customShort("l")], help: "Use SwiftLint.")
    var swiftlint = true
  }
}
