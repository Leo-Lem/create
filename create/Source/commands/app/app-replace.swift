// Created by Leopold Lemmermann on 27.05.23.

import Foundation

extension App {
  var workspace: Replacement {
    var files = ""

    if general.repo {
      files.append(fileRef(for: ".git"))
      files.append(fileRef(for: Template.gitignore.rawValue))
    }

    if general.readme { files.append(fileRef(for: Template.readme.rawValue)) }

    if general.license { files.append(fileRef(for: Template.license.rawValue)) }

    files.append(fileRef(for: "app/app.xcodeproj"))
    files.append(fileRef(for: "res"))

    return .other(match: "<#WORKSPACE_FILES#>", replacement: files)
  }
}

private extension App {
  func fileRef(for name: String) -> String {
    return  "<FileRef location = \"group:\(name)\"></FileRef>\n"
  }
}
