// Created by Leopold Lemmermann on 27.05.23.

import ArgumentParser

extension App {
  struct Options: ParsableArguments {
    @Option(name: .shortAndLong, help: "Your organisation name. (for Bundle identifier)")
    var organisation: String

    @Option(name: [.long, .customShort("i")], help: "Your team ID. (default: select manually in Xcode)")
    var teamID: String?

    @Flag(name: [.long, .customShort("l")], inversion: .prefixedNo, help: "Use SwiftLint.")
    var swiftlint = true

    @Flag(name: .long, inversion: .prefixedNo, help: "Use the composable architecture.")
    var tca = true
  }
}
