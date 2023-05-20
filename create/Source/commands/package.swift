// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser
import struct Foundation.URL
import struct Foundation.Date

struct Package: ParsableCommand {
  static let configuration = CommandConfiguration(abstract: "Creates a new package.")

  @OptionGroup var title: TitleOption
  @OptionGroup var path: PathOption
  @OptionGroup var general: GeneralFlags
  @OptionGroup var ci: CIFlag

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
      
      print("Opening project…")
      try Shell.openProject(at: project)
    } catch {
      print("Oops... Something went wrong:\n\t\(error)")
    }
  }
}

private extension Package {
  var files: [String] {
    var files = [String]()
    
    if general.readme { files.append("README.md") }
    if general.license { files.append("LICENSE") }
    if general.repo { files.append(".gitignore") }
    
    return files
  }
  
  var folders: [String] {
    var files = [String]()
    
    if ci.ci { files.append(".github") }
    
    return files
  }
  
  func fetchTemplates() throws -> URL {
    try Shell.fetchTemplates(folders: folders + ["package"], files: files)
  }
  
  func stageFiles(from downloads: URL) throws -> URL {
    let staging = try Files.getTempDir("leolem.create.staging")
    
    try Files.moveAll(in: downloads.appending(component: "package"), to: staging)

    for file in files + folders {
      try Files.move(from: downloads.appending(component: file), to: staging.appending(component: file))
    }
    
    return staging
  }
  
  func rename(in stage: URL) throws {
    for (match, replacement) in [
      "<#TITLE#>": title.title,
      "<#PLATFORMS#>": DEFAULT_PLATFORMS, // TODO: make configurable
      "<#SWIFT_TOOLS_VERSION#>": DEFAULT_SWIFT_TOOLS_VERSION, // TODO: make configurable
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
