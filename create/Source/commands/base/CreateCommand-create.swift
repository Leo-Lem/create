// Created by Leopold Lemmermann on 27.05.23.

import struct Foundation.URL
import func Foundation.fflush
import var Foundation.stdout

extension CreateCommand {
  func create(project: URL, repo: Bool, open: Bool) {
    do {
      print("Starting \(Self.category) creation…")

      print("Fetching templates…")
      let downloads = try fetchTemplates()

      print("Preparing your \(Self.category)…")
      let stage = try createStage()
      try self.stage(from: downloads, to: stage)

      print("Individualising templates…")
      try replace(in: stage)

      print("Moving to '\(project.path())'…")
      try unstage(from: stage, to: project)

      if repo {
        print("Initializing git repository…")
        try Shell.setupRepo(at: project)
      }

      if open {
        print("Opening \(Self.category)…")
        try Shell.openProject(at: project)
      }

      print("Done! Enjoy your new \(Self.category) :)")
    } catch {
      print("Oops... Something went wrong:\n\t\(error)")
    }
  }
}

private extension CreateCommand {
  func fetchTemplates() throws -> URL {
    try Shell.fetchTemplates(folders: folders, files: files)
  }

  func createStage() throws -> URL {
    try Files.getTempDir("leolem.create.staging")
  }

  func replace(in stage: URL) throws {
    try replacements.forEach { try $0.replace(in: stage) }
  }

  func unstage(from stage: URL, to project: URL) throws {
    try Files.create(at: project)
    try Files.moveAll(in: stage, to: project)
  }
}
