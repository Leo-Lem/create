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
      if general.license != .none { actions += BaseActions.license(general.license) }
      if general.repo { actions += BaseActions.gitignore() }
      
      actions += try BaseActions.replace(title: location.title, name: general.userName)

      print("Fetching templates…")
      let templates = try download(actions)

      print("Preparing your \(category)…")
      let stage = try stage(actions, from: templates)

      print("Individualising templates…")
      try replace(actions, in: stage)

      print("Moving to '\(location.project.path())'…")
      try unstage(from: stage, to: location.project)

      print("Additional setup…")
      try runAfterSetup()

      if general.repo {
        print("Initializing git repository…")
        try Shell.initRepo(at: location.project)
      }

      if general.open {
        print("Opening \(category)…")
        try Shell.openProject(at: location.project)
      }

      print("Done! Enjoy your new \(category) :)")
    } catch {
      print("Oops... Something went wrong:\n\t\(error)")
    }
  }
}
