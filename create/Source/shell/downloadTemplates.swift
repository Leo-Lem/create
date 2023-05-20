// Created by Leopold Lemmermann on 20.05.23.

import struct Foundation.URL
import class Foundation.FileManager

extension Shell {
  static func fetchTemplates(folders: String..., files: String...) throws -> URL {
    let temp = try Files.getTempDir("leolem.create.downloads")
    let patterns = folders.map { "templates/\($0)" } + files.map  { "/templates/\($0)" }
    
    try run(
      "cd \(temp.path())",
      "git init",
      "git remote add origin \(REPOSITORY_URL)",
      "git sparse-checkout set --no-cone \(patterns.joined(separator: " "))",
      "git pull origin new-version"
    )
    
    return temp.appending(component: "templates")
  }
}
