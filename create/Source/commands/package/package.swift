// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser

struct Package: ParsableCommand {
  static let configuration = CommandConfiguration(abstract: "Creates a new package.")

  @OptionGroup var title: TitleOption
  @OptionGroup var path: PathOption
  @OptionGroup var options: Options
  @OptionGroup var general: GeneralFlags

  func run() {
    do {
      print("Starting package creation…")

      print("Fetching templates…")
      let downloads = try fetchTemplates()

      print("Preparing your project…")
      let stage = try stageFiles(from: downloads)
      try rename(in: stage)

      let project = path.path.appending(component: title.title)

      print("Moving to \(project.path())…")
      try move(from: stage, to: project)

      print("Initializing git repository…")
      try Shell.setupRepo(at: project)

      if general.open {
        print("Opening project…")
        try Shell.openProject(at: project)
      }

      print("Done!")
    } catch {
      print("Oops... Something went wrong:\n\t\(error)")
    }
  }
}
