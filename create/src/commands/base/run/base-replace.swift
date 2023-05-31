// Created by Leopold Lemmermann on 31.05.23.

import struct Foundation.URL

extension CreateCommand {
  func replace(_ actions: [Action], in stage: URL) throws {
    try actions.compactMap(\.matchAndReplacement).forEach { match, replacement, path in
      if let path {
        try Shell.replace(match, in: stage.appending(path: path), with: replacement)
      } else {
        try Shell.replace(match, in: stage, with: replacement)
      }
    }

    try Shell.replace("<#[A-Z_]*#>", in: stage, with: "")
  }
}
