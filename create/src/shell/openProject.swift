// Created by Leopold Lemmermann on 20.05.23.

import Foundation

extension Shell {
  static func openProject(at dir: URL) throws {
    try run("xed \(dir.path())")
  }
}
