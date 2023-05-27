// Created by Leopold Lemmermann on 27.05.23.

import Foundation

extension App {
  var replacements: [Replacement] { [
    .title(location.title),
    .name(),
    .date,
    .year,
    .organisation(options.organisation),
    .teamId(options.teamID),
    workspace
  ] }

  var workspace: Replacement {
    var files = [String]()

    if general.repo {
      files.append(".git")
      files.append(Template.gitignore.rawValue)
    }

    if general.readme { files.append(Template.readme.rawValue) }

    if general.license { files.append(Template.license.rawValue) }

    files.append("app/app.xcodeproj")
    files.append("res")

    return .other(
      match: "<#WORKSPACE_FILES#>",
      replacement: files.map { "<FileRef location = \"group:\($0)\"></FileRef>"}.joined(separator: "\n")
    )
  }
}
