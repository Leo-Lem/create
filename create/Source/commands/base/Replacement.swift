// Created by Leopold Lemmermann on 27.05.23.

import struct Foundation.Date
import struct Foundation.URL

enum Replacement {
  case title(String)
  case name(String? = nil)
  case date
  case year
  case platforms([String])
  case swiftToolsVersion(String)
  case organisation(String)
  case teamId(String? = nil)
  case other(match: String, replacement: String)

  var match: String {
    switch self {
    case .title: return "<#TITLE#>"
    case .name: return "<#NAME#>"
    case .date: return "<#DATE#>"
    case .year: return "<#YEAR#>"
    case .platforms: return "<#PLATFORMS#>"
    case .swiftToolsVersion: return "<#SWIFT_TOOLS_VERSION#>"
    case .organisation: return "<#ORGANISATION#>"
    case .teamId: return "<#TEAM_ID#>"
    case let .other(match, _): return match
    }
  }

  var replacement: String {
    get throws {
      switch self {
      case let .title(title): return title
      case let .name(name): return try name ?? Files.getName()
      case .date: return Date.now.formatted(Date.FormatStyle().day(.twoDigits).month(.twoDigits).year(.defaultDigits))
      case .year: return Date.now.formatted(Date.FormatStyle().year(.defaultDigits))
      case let .platforms(platforms): return platforms.joined(separator: ", ")
      case let .swiftToolsVersion(version): return version
      case let .organisation(organisation): return organisation
      case let .teamId(id): return id ?? "YOUR_TEAM_ID_HERE"
      case let .other(_, replacement): return replacement
      }
    }
  }
}

extension Replacement {
  func replace(in stage: URL) throws {
    try Shell.replace(match, in: stage, with: replacement)
  }
}
