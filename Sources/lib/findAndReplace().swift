//	Created by Leopold Lemmermann on 06.12.22.

import Foundation

func findAndReplace(in dir: URL, find match: String, replace replacement: String) throws {
  // replacing all filename placeholders
  try shell(
    "cd \(dir.path()) && " +
      "find . -name \"*\(match)*\" | " +
      "sed -e 's/\\(.*\\)\\(\(match)\\)\\(.*\\)/mv \"\\1\\2\\3\" \"\\1\(replacement)\\3\"/g' |" +
      "zsh"
  )

  // replacing all in-file placeholders
  try shell(
    "cd \(dir.path()) && " +
      "grep -rl '\(match)' . | " +
      "LC_ALL=C xargs sed -i  '' 's/\(match)/\(replacement)/g'"
  )
}
