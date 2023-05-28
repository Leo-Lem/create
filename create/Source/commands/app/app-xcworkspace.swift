// Created by Leopold Lemmermann on 27.05.23.

import Foundation

extension App {
  var xcworkspace: Replacement {
    var files = [String]()

    if general.repo {
      files.append(".git")
      files.append(Template.gitignore.name)
    }
    if general.readme { files.append(Template.readme.name) }
    if general.license { files.append(Template.license.name) }

    files.append("app/app.xcodeproj")
    files.append("res")

    return .other(
      match: "<#WORKSPACE_FILES#>",
      replacement: files.map { "<FileRef location = \"group:\($0)\"></FileRef>" }.joined(separator: "\n")
    )
  }
}
