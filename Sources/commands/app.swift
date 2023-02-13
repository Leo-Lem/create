// Created by Leopold Lemmermann on 14.02.23.

import ArgumentParser
import Foundation

extension Create {
  struct App: ParsableCommand {
    static var configuration = CommandConfiguration(abstract: "Creates a default app.")
    
    // TODO: set up composable architecture
    
    @Option(name: .shortAndLong, help: "The name of the app.") var name: String
    @Option(name: .shortAndLong, help: "The name of the project (leave blank to use app name).") var projectName: String?
    @OptionGroup var baseDir: DirOption
    
    private var templateName = "AppTemplate"
    private var templateDir: URL { baseDir.url.appending(component: templateName) }
    private var projectDir: URL { baseDir.url.appending(component: projectName ?? name) }
    
    func run() {
      do {
        print("Starting package creation...")
        try Create.cloneRepo(named: templateName, into: baseDir.url)
        
        // renaming
        try findAndReplace(in: templateDir, find: "<#App#>", replace: name)
        try findAndReplace(in: templateDir, find: "<#Project#>", replace: projectName ?? name)
        try findAndReplace(in: templateDir, find: "--Project--", replace: projectName ?? name)
        
        // removing the template git repo
        try shell("cd \(templateDir.path()) && rm -rf .git")
        
        // renaming the directory
        try shell("cd \(baseDir.url.path()) && mv \(templateName) \(projectName ?? name)")
        
        try Create.initGit(in: projectDir)
        print("Your new library is ready at \(projectDir.path())")
        
        try Create.openXcode(with: projectDir)
      } catch {
        print("Oops... Something went wrong: \(error)")
      }
    }
  }
}
