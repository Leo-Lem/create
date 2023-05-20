// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser
import Foundation

struct DirectoryOption: ParsableArguments {
  @Option(name: .shortAndLong, help: "Where to create your project (defaults to home).")
  private var dir: String?

  var url: URL {
    if let dir, let url = URL(string: dir) {
      return url
    } else {
      return FileManager.default.homeDirectoryForCurrentUser
    }
  }
}
