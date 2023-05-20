// Created by Leopold Lemmermann on 20.05.23.

import struct ArgumentParser.CommandConfiguration
import protocol ArgumentParser.ParsableCommand

@main
struct Create: ParsableCommand {
  static var configuration = CommandConfiguration(
    abstract: "A utility for creating new Xcode projects, packages and whatever else…",
    subcommands: []
  )
}
