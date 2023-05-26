// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser
import Foundation

struct PathOption: ParsableArguments {
  @Option(
    name: .shortAndLong,
    help: "Where to create your project. (default: home)",
    completion: .directory,
    transform: { URL(filePath: $0) }
  ) var path = FileManager.default.homeDirectoryForCurrentUser
}
