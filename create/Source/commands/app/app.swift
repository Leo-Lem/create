// Created by Leopold Lemmermann on 26.05.23.

import ArgumentParser

struct App: CreateCommand {
  static let category = "app", configuration = CommandConfiguration(abstract: "Creates a new app.")
  
  @OptionGroup var location: LocationOption
  @OptionGroup var options: Options
  @OptionGroup var general: GeneralFlags
  
  func run() {
    create(project: location.project, repo: general.repo, open: general.open)
  }
}
