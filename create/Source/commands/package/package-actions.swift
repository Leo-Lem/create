// Created by Leopold Lemmermann on 26.05.23.

import struct Foundation.Date
import struct Foundation.URL

extension Package {
  func fetchTemplates() throws -> URL {
    try Shell.fetchTemplates(folders: folders, files: files)
  }

  func stageFiles(from downloads: URL) throws -> URL {
    let staging = try Files.getTempDir("leolem.create.staging")

    try Files.moveAll(in: downloads.appending(component: "package"), to: staging)

    for file in files + folders {
      try Files.move(
        from: downloads.appending(component: file.rawValue),
        to: staging.appending(component: file.rawValue)
      )
    }

    return staging
  }

  func rename(in stage: URL) throws {
    for (match, replacement) in [
      "<#TITLE#>": title.title,
      "<#PLATFORMS#>": options.platforms.joined(separator: ", "),
      "<#SWIFT_TOOLS_VERSION#>": options.swiftToolsVersion,
      "<#NAME#>": try Files.getName(),
      "<#DATE#>": Date.now.formatted(Date.FormatStyle().day(.twoDigits).month(.twoDigits).year(.defaultDigits)),
      "<#YEAR#>": Date.now.formatted(Date.FormatStyle().year(.defaultDigits))
    ] {
      try Shell.replace(match, in: stage, with: replacement)
    }
  }

  func move(from stage: URL, to project: URL) throws {
    try Files.create(at: project)
    try Files.moveAll(in: stage, to: project)
  }
}
