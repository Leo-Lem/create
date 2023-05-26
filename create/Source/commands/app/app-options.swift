// Created by Leopold Lemmermann on 26.05.23.

import ArgumentParser

extension App {
  struct Options: ParsableArguments {
    @Option(name: .shortAndLong, help: "Your organisation name. (for the Bundle identifier)")
    var organisation: String
    
    @Option(name: [.long, .customShort("i")], help: "Your team ID. (if omitted, select manually in Xcode)")
    var teamID: String?
  }
}
