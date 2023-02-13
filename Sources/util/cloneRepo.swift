// Created by Leopold Lemmermann on 14.02.23.

import ArgumentParser
import Foundation

extension Create {
  static func cloneRepo(named name: String, into dir: URL) throws {
    try shell(
      "cd '\(dir.path())' && " +
        "git clone 'https://github.com/Leo-Lem/\(name).git'"
    )
  }
}
