// Created by Leopold Lemmermann on 20.05.23.

import struct Foundation.URL
import class Foundation.FileManager

extension Shell {
  static func fetchTemplates(folders: String..., files: String...) throws -> [URL] {
    let temp = FileManager.default.temporaryDirectory.appending(component: "create-temp")
    
    let patterns = folders.map { "templates/\($0)" } + files.map  { "/templates/\($0)" }
    
    try run(
      "rm -rf \(temp.path())",
      "mkdir \(temp.path())",
      "cd \(temp.path())",
      "git init",
      "git remote add origin \(REPOSITORY_URL)",
      "git sparse-checkout set --no-cone \(patterns.joined(separator: " "))",
      "git pull origin new-version"
    )
    
    return patterns.map { temp.appending(path: $0) }
  }
}
