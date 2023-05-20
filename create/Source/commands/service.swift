// Created by Leopold Lemmermann on 14.02.23.

import ArgumentParser
import Foundation

extension Create {
  struct Service: ParsableCommand {
    static var configuration = CommandConfiguration(abstract: "Creates a default service package.")
    
    @Option(name: .shortAndLong, help: "The name of the service.") var name: String
    @Option(name: .shortAndLong, help: "The name of the implementation.") var implementationName: String
    @OptionGroup var baseDir: DirOption
    
    private var templateName = "ServiceTemplate"
    private var templateDir: URL { baseDir.url.appending(component: templateName) }
    private var projectDir: URL { baseDir.url.appending(component: name) }
    
    func run() {
      do {
        print("Starting package creation...")
        try Create.cloneRepo(named: templateName, into: baseDir.url)
        
        // renaming
        try findAndReplace(in: templateDir, find: "<#Service#>", replace: name)
        try findAndReplace(in: templateDir, find: "<#Implementation#>", replace: implementationName)
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
