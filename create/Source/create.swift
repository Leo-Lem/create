import ArgumentParser

@main
struct Create: ParsableCommand {
  static var configuration = CommandConfiguration(
    abstract: "A utility for creating default Xcode projects.",
    subcommands: [Library.self, Service.self, App.self]
  )
}
