// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser

struct Package: ParsableCommand {
  static let configuration = CommandConfiguration(abstract: "Creates a new package.")

  @OptionGroup var title: TitleOption
  @OptionGroup var directory: DirectoryOption
  @OptionGroup var general: GeneralFlags
  @OptionGroup var ci: CIFlag

  func run() {
    do {
      print("Starting package creation...")

      let urls = try Shell.fetchTemplates(folders: "package", files: "README.md", "LICENSE")
      guard urls.count == 3 else { return print("Failed to fetch templates: Please try again later…") }
      let package = urls[0]
      let readme = urls[1]
      let license = urls[2]
      
      let staging = try Shell.getTempDir("leolem.create.staging")
    } catch {
      print("Oops... Something went wrong: \(error)")
    }
  }
}
