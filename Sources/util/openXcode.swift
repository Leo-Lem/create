// Created by Leopold Lemmermann on 14.02.23.

import ArgumentParser
import Foundation

extension Create {
  static func openXcode(with dir: URL) throws {
    try shell(
      "cd \(dir.path()) && " +
        "xed ."
    )
  }
}
