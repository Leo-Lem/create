// Created by Leopold Lemmermann on 26.05.23.

import struct Foundation.URL

enum Template {
  case package(Package.Kind)
  case app(App.Kind)
  case license
  case readme
  case gitignore
  case swiftlint
  case githubCI
  case fullTestplan
  case unitTestplan
  case xcworkspace
  case xcproject
  case xcscheme
  case other(String, dir: String? = nil)
}

extension Template {
  var name: String {
    switch self {
    case let .package(kind):
      switch kind {
      case .plain: return "plain"
      case .tcaFeature: return "tca-feature"
      }
    case let .app(kind):
      switch kind {
      case .default: return "default"
      case .simple: return "simple"
      case .tca: return "tca"
      }
    case .license: return "MIT"
    case .readme: return "README.md"
    case .gitignore: return ".gitignore"
    case .swiftlint: return ".swiftlint.yml"
    case .githubCI: return "ci.yml"
    case .fullTestplan: return "full.xctestplan"
    case .unitTestplan: return "unit.xctestplan"
    case .xcworkspace: return ".xcworkspace"
    case .xcproject: return ".xcodeproj"
    case .xcscheme: return ".xcscheme"
    case let .other(name, _): return name
    }
  }

  var dir: String? {
    switch self {
    case .package: return "packages"
    case .app: return "apps"
    case .license: return "licenses"
    case .gitignore, .swiftlint, .githubCI, .fullTestplan, .unitTestplan: return "config"
    case .xcworkspace, .xcproject, .xcscheme: return "xcode"
    case let .other(_, dir): return dir
    default: return nil
    }
  }

  var path: String {
    if let dir { return "\(dir)/\(name)" } else { return name }
  }
}

extension Template {
  func copy(from origin: URL, to destination: URL, rename: String? = nil) throws {
    try Files.copy(
      from: origin.appending(path: path),
      to: destination.appending(path: rename ?? name)
    )
  }

  func move(from origin: URL, to destination: URL, rename: String? = nil) throws {
    try Files.move(
      from: origin.appending(path: path),
      to: destination.appending(path: rename ?? name)
    )
  }

  func moveAll(from origin: URL, into destination: URL) throws {
    try Files.moveAll(in: origin.appending(component: path), to: destination)
  }
}
