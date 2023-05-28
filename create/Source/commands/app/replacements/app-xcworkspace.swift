// Created by Leopold Lemmermann on 27.05.23.

import Foundation

extension Replacement {
  static func xcworkspace(_ general: CreateCommandOptions) -> Self {
    var files = [String]()

    if general.repo { files += [".git", Template.gitignore.name] }
    if general.readme { files.append(Template.readme.name) }
    if general.license { files.append(Template.license.name) }

    files.append("app/app.xcodeproj")
    files.append(Template.res.name)

    return .xcworkspace(files)
  }

  static func xcworkspace(_ fileRefs: [String]) -> Self {
    .replacement(
      "<#WORKSPACE_FILES#>", fileRefs.map { "<FileRef location = \"group:\($0)\"></FileRef>" }.joined(separator: "\n")
    )
  }
}
