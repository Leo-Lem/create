// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser

@main
struct Create: ParsableCommand {
  static var configuration = CommandConfiguration(
    abstract: "An opinionated utility for creating new Xcode projects, packages and whatever else…",
    subcommands: [Package.self, App.self]
  )
}
