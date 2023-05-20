// Created by Leopold Lemmermann on 20.05.23.

import struct Foundation.URL

extension Shell {
  static func replace(_ match: String, in dir: URL, with replacement: String) throws {
    try replaceNames(match, in: dir, with: replacement)
    try replaceInFiles(match, in: dir, with: replacement)
  }

  static func replaceNames(_ match: String, in dir: URL, with replacement: String) throws {
    try run(
      "cd \(dir.path())",
      "find . -name \"*\(match)*\" | "
        + "sed -e 's/\\(.*\\)\\(\(match)\\)\\(.*\\)/mv \"\\1\\2\\3\" \"\\1\(replacement)\\3\"/g' |"
        + "zsh"
    )
  }

  static func replaceInFiles(_ match: String, in dir: URL, with replacement: String) throws {
    try run(
      "cd \(dir.path())",
      "grep -rl '\(match)' . | "
        + "LC_ALL=C xargs sed -i  '' 's/\(match)/\(replacement)/g'"
    )
  }
}
