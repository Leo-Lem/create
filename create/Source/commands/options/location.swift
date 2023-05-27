// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser
import Foundation

struct LocationOption: ParsableArguments {
  @Option(name: .shortAndLong, help: "The title of your project.") var title: String

  @Option(
    name: .shortAndLong,
    help: "Where to create your project. (default: home)",
    completion: .directory,
    transform: { URL(filePath: $0) }
  ) private var path = FileManager.default.homeDirectoryForCurrentUser

  var project: URL { path.appending(component: title) }
}
