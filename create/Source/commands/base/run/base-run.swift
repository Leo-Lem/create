// Created by Leopold Lemmermann on 27.05.23.

extension CreateCommand {
  var category: String { Mirror(reflecting: self).description.split(separator: " ").last?.lowercased() ?? "project" }
  
  @_disfavoredOverload
  func runAfterSetup() throws {}

  func run() {
    do {
      print("Starting \(category) creation…")
      var actions = [Action]()
      addActions(to: &actions)

      if general.readme { actions += BaseActions.readme() }
      if general.license { actions += BaseActions.license(.mit) } // TODO: add more licenses
      if general.repo { actions += BaseActions.gitignore() }
      
      actions += try BaseActions.replace(title: general.title, name: general.name)

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
