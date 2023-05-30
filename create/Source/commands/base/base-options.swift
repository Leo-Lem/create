// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser
import class Foundation.FileManager
import struct Foundation.URL

struct CreateCommandOptions: ParsableArguments {
  @Argument(help: "The title of your project.") var title: String

  @Option(
    name: .shortAndLong,
    help: "Where to create your project. (default: home)",
    completion: .directory,
    transform: { URL(filePath: $0) }
  ) var path = FileManager.default.homeDirectoryForCurrentUser

  var project: URL { path.appending(component: title) }

  @Option(name: .shortAndLong, help: "Your name. (default: user name)") var name: String? = nil

  @Flag(name: .long, inversion: .prefixedNo, help: "Adds a README file.") var readme = true
  @Flag(name: .long, inversion: .prefixedNo, help: "Adds an MIT license.") var license = true
  @Flag(name: .long, inversion: .prefixedNo, help: "Initializes a git repository.") var repo = true
  @Flag(name: .long, inversion: .prefixedNo, help: "Opens the project in Xcode.") var open = true
}

extension CreateCommandOptions {
  init(title: String, path: URL, name: String?, readme: Bool, license: Bool, repo: Bool, open: Bool) {
    self.title = title
    self.path = path
    self.name = name
    self.readme = readme
    self.license = license
    self.repo = repo
    self.open = open
  }
}
