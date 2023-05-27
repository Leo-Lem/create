// Created by Leopold Lemmermann on 20.05.23.

import Foundation

extension Shell {
  static func fetchTemplates(folders: [Template], files: [Template]) throws -> URL {
    let temp = try Files.getTempDir("leolem.create.downloads")
    let patterns = folders.map { "templates/\($0.rawValue)" } + files.map { "/templates/\($0.rawValue)" }

    try run(
      "cd \(temp.path())",
      "git init",
      "git remote add origin https://github.com/Leo-Lem/create.git",
      "git sparse-checkout set --no-cone \(patterns.joined(separator: " "))",
      "git pull origin \(templateBranch)"
    )

    return temp.appending(component: "templates")
  }

  #if DEBUG
    static let templateBranch = ProcessInfo.processInfo.environment["TEMPLATE_BRANCH"]!
  #else
    static let templateBranch = "main"
  #endif
}
