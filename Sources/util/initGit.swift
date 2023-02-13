// Created by Leopold Lemmermann on 14.02.23.

import ArgumentParser
import Foundation

extension Create {
  static func initGit(in dir: URL) throws {
    try shell(
      "cd \(dir.path()) && " +
        "git init && " +
        "git add . && " +
        "git commit -m 'Initial Commit.'"
    )
  }
}
