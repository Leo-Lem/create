// Created by Leopold Lemmermann on 27.05.23.

import struct Foundation.Date
import struct Foundation.URL

enum Replacement {
  case replacement(_ match: String, _ replacement: String)

  var match: String {
    switch self {
    case let .replacement(match, _): return match
    }
  }

  var replacement: String {
    get throws {
      switch self {
      case let .replacement(_, replacement): return replacement
      }
    }
  }
}

extension Replacement {
  func replace(in stage: URL) throws {
    try Shell.replace(match, in: stage, with: replacement)
  }
}
