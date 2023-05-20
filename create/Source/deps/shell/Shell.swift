// Created by Leopold Lemmermann on 20.05.23.

import Dependencies
import Foundation

struct Shell {
  var run: (_ command: String) throws -> String?
  
  enum Error: Swift.Error {
    case running(Swift.Error)
    case fileHandle(Swift.Error)
    case failed(String?)
  }
}

extension Shell: DependencyKey {
  static let liveValue = Shell(run: run)
}

extension DependencyValues {
  var shell: Shell { self[Shell.self] }
}
