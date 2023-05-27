// Created by Leopold Lemmermann on 27.05.23.

import ArgumentParser

extension Package {
  struct Options: ParsableArguments {
    @Flag(name: .long, inversion: .prefixedNo, help: "Adds Github Actions CI config.") var ci = true
    @Option(name: .long, help: "The Swift tools version.") var swiftToolsVersion = "5.8"
    @Option(
      name: .long,
      parsing: .upToNextOption,
      help: "The supported platforms."
    ) var platforms = [".iOS(.v13)", ".macOS(.v10_15)"]
  }
}
