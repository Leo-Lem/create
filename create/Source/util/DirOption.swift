// Created by Leopold Lemmermann on 14.02.23.

import ArgumentParser
import Foundation

extension Create {
  struct DirOption: ParsableArguments {
    @Option(name: .shortAndLong, help: "The directory to create the package in (defaults to home).") private var dir: String?

    var url: URL {
      if let dir, let url = URL(string: dir) {
        return url
      } else {
        return FileManager.default.homeDirectoryForCurrentUser
      }
    }
  }
}
