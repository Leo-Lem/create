//	Created by Leopold Lemmermann on 16.11.22.

import Foundation

extension CreatePackage {
  func rename() throws {
    do {
      let base = dir.appending(component: kind.template)

      // replacing the placeholders
      switch kind {
      case .library:
        try findAndReplace(base, find: "<#Library#>", replace: names[0])
      case .service:
        for (placeholder, replacement) in [
          "<#Service#>": names[0],
          "<#Implementation#>": names[1]
        ] {
          try findAndReplace(base, find: placeholder, replace: replacement)
        }
      }

      // removing the template git repo & the script itself
      try shell("cd \(base.path()) && rm -rf .git")
      try shell("cd \(base.path()) && rm create")
      
      // renaming the package directory
      try shell("cd \(dir.path()) && mv \(kind.template) \(names[0])")
    } catch {
      throw Failure.renaming(error)
    }
  }

  private func findAndReplace(_ dir: URL, find match: String, replace replacement: String) throws {
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
}
