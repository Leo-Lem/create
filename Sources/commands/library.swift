// Created by Leopold Lemmermann on 14.02.23.

import ArgumentParser
import Foundation

extension Create {
  struct Library: ParsableCommand {
    static var configuration = CommandConfiguration(abstract: "Creates a default library package.")
    
    @Option(name: .shortAndLong, help: "The name of the library.") var name: String
    @OptionGroup var baseDir: DirOption
    
    private var templateName = "LibraryTemplate"
    private var templateDir: URL { baseDir.url.appending(component: templateName) }
    private var projectDir: URL { baseDir.url.appending(component: name) }
    
    func run() {
      do {
        print("Starting package creation...")
        try Create.cloneRepo(named: templateName, into: baseDir.url)
        
        // renaming
        try findAndReplace(in: templateDir, find: "<#Library#>", replace: name)
        // removing the template git repo
        try shell("cd \(templateDir.path()) && rm -rf .git")
        // renaming the directory
        try shell("cd \(baseDir.url.path()) && mv \(templateName) \(name)")
        
        try Create.initGit(in: projectDir)
        print("Your new library is ready at \(projectDir.path())")
        
        try Create.openXcode(with: projectDir)
      } catch {
        print("Oops... Something went wrong: \(error)")
      }
    }
  }
}


