// Created by Leopold Lemmermann on 26.05.23.

import struct Foundation.URL

enum Template {
  case package(Package.Kind)
  case app
  case res
  case license
  case readme
  case gitignore
  case swiftlint
  case githubCI
  case xcworkspace
  case xcproject
  case other(String)
}

extension Template {
  var name: String {
    switch self {
    case let .package(kind):
      switch kind {
      case .plain: return "packages/plain"
      case .tcaFeature: return "packages/tca-feature"
      }
    case .app: return "app"
    case .res: return "res"
    case .license: return "LICENSE"
    case .readme: return "README.md"
    case .gitignore: return ".gitignore"
    case .swiftlint: return ".swiftlint.yml"
    case .githubCI: return ".github"
    case .xcworkspace: return ".xcworkspace"
    case .xcproject: return ".xcodeproj"
    case .other(let name): return name
    }
  }
}

extension Template {
  func copy(from origin: URL, to destination: URL, rename: String? = nil) throws {
    try Files.copy(
      from: origin.appending(component: name),
      to: destination.appending(component: rename ?? name)
    )
  }

  func move(from origin: URL, to destination: URL, rename: String? = nil) throws {
    try Files.move(
      from: origin.appending(component: name),
      to: destination.appending(component: rename ?? name)
    )
  }

  func moveAll(from origin: URL, into destination: URL) throws {
    try Files.moveAll(in: origin.appending(component: name), to: destination)
  }
}


