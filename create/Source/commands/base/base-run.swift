// Created by Leopold Lemmermann on 27.05.23.

import func Foundation.fflush
import var Foundation.stdout
import struct Foundation.URL

extension CreateCommand {
  func run() {
    do {
      print("Starting \(category) creation…")

      print("Fetching templates…")
      let downloads = try fetchTemplates()

      print("Preparing your \(category)…")
      let stage = try self.stage(from: downloads)

      print("Individualising templates…")
      try replace(in: stage)

      print("Moving to '\(general.project.path())'…")
      try unstage(from: stage, to: general.project)

      if general.repo {
        print("Initializing git repository…")
        try Shell.setupRepo(at: general.project)
      }

      if general.open {
        print("Opening \(category)…")
        try Shell.openProject(at: general.project)
      }

      print("Done! Enjoy your new \(category) :)")
    } catch {
      print("Oops... Something went wrong:\n\t\(error)")
    }
  }
}

private extension CreateCommand {
  var category: String { Mirror(reflecting: self).description.split(separator: " ").last?.lowercased() ?? "project" }

  func fetchTemplates() throws -> URL {
    var downloads = [Template]()
    try add(templates: &downloads)
    if general.readme { downloads.append(.readme) }
    if general.license { downloads.append(.license) }
    if general.repo { downloads.append(.gitignore) }

    return try Shell.fetchTemplates(downloads.map(\.name))
  }

  func stage(from downloads: URL) throws -> URL {
    let stage = try Files.getTempDir("leolem.create.staging")

    if general.readme { try Template.readme.move(from: downloads, to: stage) }
    if general.license { try Template.license.move(from: downloads, to: stage) }
    if general.repo { try Template.gitignore.move(from: downloads, to: stage) }

    try self.stage(from: downloads, to: stage)

    return stage
  }

  func replace(in stage: URL) throws {
    var replacements  = [Replacement]()
    try add(replacements: &replacements)
    replacements.append(contentsOf: [.title(general.title), .name(general.name), .date, .year])

    try replacements.forEach { try $0.replace(in: stage) }
  }

  func unstage(from stage: URL, to project: URL) throws {
    try Files.create(at: project)
    try Files.moveAll(in: stage, to: project)
  }
}
