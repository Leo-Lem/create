//	Created by Leopold Lemmermann on 16.11.22.

import Foundation

public struct PackageCreator {
  var kind: Kind?,
      names: [String?] = [nil, nil],
      dir: URL?

  public init() {}

  public mutating func run(_ arguments: [String] = CommandLine.arguments) {
    do {
      try runWithError(arguments)
    } catch {
      print(feedback: "Oops... Something went wrong: \(error)")
    }
  }
}
