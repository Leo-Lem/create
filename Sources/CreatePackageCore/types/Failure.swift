//	Created by Leopold Lemmermann on 16.11.22.

import Foundation

extension CreatePackage {
  enum Failure: Error {
    case cloningTemplate(Error),
         renaming(Error),
         initGit(Error),
         openingXcode(Error)
  }
}

extension CreatePackage.Failure: LocalizedError {
  var errorDescription: String? {
    switch self {
    case let .cloningTemplate(error):
      return "Failed to copy the template repo... \(error)"
    case let .renaming(error):
      return "Failed to rename the placeholders... \(error)"
    case let .initGit(error):
      return "Failed to initialize a git repo... \(error)"
    case let .openingXcode(error):
      return "Failed to open Xcode... \(error)"
    }
  }
}
