// Created by Leopold Lemmermann on 26.05.23.

extension Package {
  var files: [Template] {
    var files = [Template]()

    if general.readme { files.append(.readme) }
    if general.license { files.append(.license) }
    if general.repo { files.append(.gitignore) }

    return files
  }

  var folders: [Template] {
    var folders = [Template.package]

    if options.setupCI { folders.append(.githubCI) }

    return folders
  }
}
