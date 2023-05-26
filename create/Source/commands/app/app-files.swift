// Created by Leopold Lemmermann on 26.05.23.

extension App {
  var files: [Template] {
    var files = [Template]()

    if general.readme { files.append(Template.readme) }
    if general.license { files.append(Template.license) }
    if general.repo { files.append(Template.gitignore) }

    files.append(Template.swiftlint)

    return files
  }

  var folders: [Template] { [Template.app] }
}
