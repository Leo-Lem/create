// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser
import Foundation

struct DirectoryOption: ParsableArguments {
  @Option(
    name: .shortAndLong,
    help: "Where to create your project: (default: home)",
    completion: .directory,
    transform: { (dir: String?) in
      dir.flatMap(URL.init) ?? FileManager.default.homeDirectoryForCurrentUser
    }
  )
  private var dir: URL!
}
