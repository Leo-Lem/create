// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser
import class Foundation.FileManager
import struct Foundation.URL

struct LocationOptions: ParsableArguments {
  @Argument(help: "The title of your project.") var title: String

  @Option(
    name: .shortAndLong,
    help: "Where to create your project. (default: Desktop)",
    completion: .directory,
    transform: { URL(filePath: $0) }
  ) var path = try! FileManager.default.url(
    for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: false
  )

  var project: URL { path.appending(component: title) }
}

extension LocationOptions {
  init(title: String, path: URL) {
    self.title = title
    self.path = path
  }
}

struct BaseOptions: ParsableArguments {
  @Option(name: .shortAndLong, help: "Your name. (default: User name)") var userName: String?

  @Flag(name: .long, inversion: .prefixedNo, help: "Adds a README file.") var readme = true
  @Flag(name: .long, inversion: .prefixedNo, help: "Adds an MIT license.") var license = true
  @Flag(name: .long, inversion: .prefixedNo, help: "Initializes a git repository.") var repo = true
  @Flag(name: .long, inversion: .prefixedNo, help: "Opens the project in Xcode.") var open = true
}

extension BaseOptions {
  init(userName: String?, readme: Bool, license: Bool, repo: Bool, open: Bool) {
    self.userName = userName
    self.readme = readme
    self.license = license
    self.repo = repo
    self.open = open
  }
}
