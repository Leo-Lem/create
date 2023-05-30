// Created by Leopold Lemmermann on 27.05.23.

import ArgumentParser

protocol CreateCommand: ParsableCommand {
  var general: BaseOptions { get }

  func addActions(to actions: inout [Action])

  func runAfterSetup() throws
}
