// Created by Leopold Lemmermann on 27.05.23.

import struct Foundation.Date
import struct Foundation.URL

enum Replacement {
  case replacement(_ match: String, _ replacement: String)
  case replacements([Replacement])

  var match: String {
    switch self {
    case let .replacement(match, _): return match
    default: fatalError("match is ambiguous for compound.")
    }
  }

  var replacement: String {
    get throws {
      switch self {
      case let .replacement(_, replacement): return replacement
      default: fatalError("replacement is ambiguous for compound.")
      }
    }
  }
}

extension Replacement {
  func replace(in stage: URL) throws {
    if case .replacements(let replacements) = self {
      try replacements.forEach { replacement in try replacement.replace(in: stage) }
    }
      try Shell.replace(match, in: stage, with: replacement)
    }
}
