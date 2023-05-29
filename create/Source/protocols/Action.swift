// Created by Leopold Lemmermann on 28.05.23.

import Foundation

enum Action {
  case download(String)
  case stage(String, rename: String? = nil)
  case stageCopy(String, rename: String? = nil)
  case replace(String, replacement: String)
}

extension Action {
  var downloadPath: String? {
    if case let .download(path) = self { return path } else { return nil }
  }

  var stagePath: (String, rename: String?, copy: Bool)? {
    switch self {
    case let .stage(path, rename): return (path, rename, false)
    case let .stageCopy(path, rename): return (path, rename, true)
    default: return nil
    }
  }

  var matchAndReplacement: (String, String)? {
    if case let .replace(match, replacement) = self { return (match, replacement) } else { return nil }
  }
}

extension Action: Hashable {
}
