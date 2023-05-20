// Created by Leopold Lemmermann on 20.05.23.

import struct Foundation.URL

extension Shell {
  static func setupRepo(at url: URL) throws {
    try run(
      "cd \(url.path())",
      "git init",
      "git add .",
      "git commit -m 'Initial Commit.'"
    )
  }
}
