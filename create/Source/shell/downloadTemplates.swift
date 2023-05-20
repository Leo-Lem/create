// Created by Leopold Lemmermann on 20.05.23.

import class Foundation.FileManager
import struct Foundation.URL

extension Shell {
  static func fetchTemplates(folders: String..., files: String...) throws -> URL {
    try fetchTemplates(folders: folders, files: files)
  }

  static func fetchTemplates(folders: [String], files: [String]) throws -> URL {
    let temp = try Files.getTempDir("leolem.create.downloads")
    let patterns = folders.map { "templates/\($0)" } + files.map { "/templates/\($0)" }

    try run(
      "cd \(temp.path())",
      "git init",
      "git remote add origin https://github.com/Leo-Lem/Create.git",
      "git sparse-checkout set --no-cone \(patterns.joined(separator: " "))",
      "git pull origin new-version" // TODO: replace with main
    )

    return temp.appending(component: "templates")
  }
}
