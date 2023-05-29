// Created by Leopold Lemmermann on 27.05.23.

import ArgumentParser
import struct Foundation.URL

protocol CreateCommand: ParsableCommand {
  var general: CreateCommandOptions { get }

  func addActions(to actions: inout Set<Action>)
}
