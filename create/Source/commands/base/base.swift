// Created by Leopold Lemmermann on 27.05.23.

import ArgumentParser
import struct Foundation.URL

protocol CreateCommand: ParsableCommand {
  var general: CreateCommandOptions { get }

  func add(templates: inout [Template]) throws
  func stage(from downloads: URL, to stage: URL) throws
  func add(replacements: inout [Replacement]) throws
}
