// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser
import struct Foundation.URL

struct Package: ParsableCommand {
  static let configuration = CommandConfiguration(abstract: "Creates a new package.")

  @OptionGroup var title: TitleOption
  @OptionGroup var directory: DirectoryOption
  @OptionGroup var general: GeneralFlags
  @OptionGroup var ci: CIFlag

  func run() {
    do {
      print("Starting package creation…")

      print("Fetching templates…")
      let downloads = try fetchTemplates()
      
      print("Preparing your project…")
      let stage = try stageFiles(downloads)
      
      print(stage)
    } catch {
      print("Oops... Something went wrong:\n\t\(error)")
    }
  }
}

private extension Package {
  func fetchTemplates() throws -> URL {
    try Shell.fetchTemplates(folders: "package", files: "README.md", "LICENSE")
  }
  
  func stageFiles(_ downloads: URL) throws -> URL {
    let staging = try Files.getTempDir("leolem.create.staging")
    
    try Files.moveAll(from: downloads.appending(component: "package"), to: staging)
    
    if general.readme {
      try Files.move(from: downloads.appending(component: "README.md"), to: staging.appending(component: "README.md"))
    }
    
    if general.license {
      try Files.move(from: downloads.appending(component: "LICENSE"), to: staging.appending(component: "LICENSE"))
    }
    
    if ci.ci {
      try Files.move(from: downloads.appending(path: ".github"), to: staging.appending(component: ".github"))
    }
    
    return staging
  }
}
