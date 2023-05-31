// Created by Leopold Lemmermann on 20.05.23.

import Foundation

extension Shell {
  static func fetchTemplates(_ templates: [String], to downloads: URL) throws -> URL {
    let patterns = templates.map { "templates/\($0)" }

    try run(
      "cd \"\(downloads.path(percentEncoded: false))\"",
      "git init",
      "git remote add origin https://github.com/Leo-Lem/create.git",
      "git sparse-checkout set --no-cone \(patterns.joined(separator: " "))",
      "git pull origin \(templateBranch)"
    )

    return downloads.appending(component: "templates")
  }

  #if DEBUG
    static let templateBranch = ProcessInfo.processInfo.environment["TEMPLATE_BRANCH"]!
  #else
    static let templateBranch = "main"
  #endif
}
