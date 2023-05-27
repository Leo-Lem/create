// Created by Leopold Lemmermann on 26.05.23.

import struct Foundation.URL

enum Template: String {
  case package
  case app
  case res
  case license = "LICENSE"
  case readme = "README.md"
  case gitignore = ".gitignore"
  case swiftlint = ".swiftlint.yml"
  case githubCI = ".github"
  case xcworkspace = ".xcworkspace"
  case xcproject = ".xcodeproj"
}

extension Template {
  func copy(from origin: URL, to destination: URL, rename: String? = nil) throws {
    try Files.copy(
      from: origin.appending(component: rawValue),
      to: destination.appending(component: rename ?? rawValue)
    )
  }

  func move(from origin: URL, to destination: URL, rename: String? = nil) throws {
    try Files.move(
      from: origin.appending(component: rawValue),
      to: destination.appending(component: rename ?? rawValue)
    )
  }

  func moveAll(from origin: URL, into destination: URL) throws {
    try Files.moveAll(in: origin.appending(component: rawValue), to: destination)
  }
}


