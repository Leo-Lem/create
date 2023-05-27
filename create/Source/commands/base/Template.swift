// Created by Leopold Lemmermann on 26.05.23.

import struct Foundation.URL

enum Template: String {
  case license = "LICENSE"
  case readme = "README.md"
  case gitignore = ".gitignore"
  case swiftlint = ".swiftlint.yml"
  case githubCI = ".github"
  case package
  case app
}

extension Template {
  func copy(from source: URL, to destination: URL) throws {
    try Files.copy(from: source.appending(component: rawValue), to: destination.appending(component: rawValue))
  }

  func move(from source: URL, to destination: URL) throws {
    try Files.move(from: source.appending(component: rawValue), to: destination.appending(component: rawValue))
  }
}


