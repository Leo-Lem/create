// Created by Leopold Lemmermann on 27.05.23.

import Foundation

extension Replacement {
  static func xcworkspace(_ general: CreateCommandOptions) -> Self {
    var files = [String]()

    if general.repo { files += [".git", Template.gitignore.path] }
    if general.readme { files.append(Template.readme.path) }
    if general.license { files.append(Template.license.path) }

    files.append("app/app.xcodeproj")
    files.append("res")

    return .xcworkspace(files)
  }

  static func xcworkspace(_ fileRefs: [String]) -> Self {
    .replacement(
      "<#WORKSPACE_FILES#>", fileRefs.map { "<FileRef location = \"group:\($0)\"></FileRef>" }.joined(separator: "\n")
    )
  }
}
