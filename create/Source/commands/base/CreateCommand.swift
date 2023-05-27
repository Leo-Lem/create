// Created by Leopold Lemmermann on 27.05.23.

import ArgumentParser
import struct Foundation.URL

protocol CreateCommand: ParsableCommand {
  static var category: String { get }

  var folders: [Template] { get }
  var files: [Template] { get }
  var replacements: [Replacement] { get }

  func stage(from downloads: URL, to stage: URL) throws
}
