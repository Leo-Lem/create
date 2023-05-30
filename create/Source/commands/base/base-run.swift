// Created by Leopold Lemmermann on 27.05.23.

import Foundation

extension CreateCommand {
  @_disfavoredOverload
  func runAfterSetup() throws {}

  func run() {
    do {
      print("Starting \(category) creation…")
      var actions = [Action]()
      addActions(to: &actions)

      if general.readme {
        let readme = "README.md"
        actions += [.download(readme), .stage(readme)]
      }

      if general.license {
        let license = "licenses/MIT"
        actions += [
          .download(license),
          .stage(license, rename: "LICENSE"),
          .replace("<#YEAR#>", replacement: Date.now.formatted(Date.FormatStyle().year(.defaultDigits)))
        ]
      }

      if general.repo {
        let gitignore = ".gitignore"
        actions += [.download(gitignore), .stageCopy(gitignore)]
      }

      actions += [
        .replace("<#TITLE#>", replacement: general.title),
        .replace("<#NAME#>", replacement: try Files.getName()),
        .replace("<#DATE#>", replacement: Date.now
            .formatted(Date.FormatStyle().year(.defaultDigits).month(.twoDigits).day(.twoDigits)))
      ]

      print("Fetching templates…")
      let templates = try download(actions)

      print("Preparing your \(category)…")
      let stage = try stage(actions, from: templates)

      print("Individualising templates…")
      try replace(actions, in: stage)

      print("Moving to '\(general.project.path())'…")
      try unstage(from: stage, to: general.project)

      print("Additional setup…")
      try runAfterSetup()

      if general.repo {
        print("Initializing git repository…")
        try Shell.initRepo(at: general.project)
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

  func download(_ actions: [Action]) throws -> URL {
    let downloads = try Files.getTempDir("leolem.create.downloads")

    let templates = try Shell.fetchTemplates(actions.compactMap(\.downloadPath), to: downloads)

    return templates
  }

  func stage(_ actions: [Action], from templates: URL) throws -> URL {
    let stage = try Files.getTempDir("leolem.create.staging")

    try actions.compactMap(\.stagePath).forEach { name, rename, copy, inDir in
      let origin = templates.appending(path: name), destination = stage.appending(path: rename ?? name)

      if copy {
        try Files.copy(from: origin, to: destination)
      } else if inDir {
        try Files.moveAll(in: origin, to: stage.appending(path: rename ?? ""))
      } else {
        try Files.move(from: origin, to: destination)
      }
    }

    return stage
  }

  func replace(_ actions: [Action], in stage: URL) throws {
    try actions.compactMap(\.matchAndReplacement).forEach { match, replacement, path in
      if let path {
        try Shell.replace(match, in: stage.appending(path: path), with: replacement)
      } else {
        try Shell.replace(match, in: stage, with: replacement)
      }
    }

    try Shell.replace("<#[A-Z_]*#>", in: stage, with: "")
  }

  func unstage(from stage: URL, to project: URL) throws {
    try Files.create(at: project)
    try Files.moveAll(in: stage, to: project)
  }
}
