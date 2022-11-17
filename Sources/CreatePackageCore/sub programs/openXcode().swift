//	Created by Leopold Lemmermann on 16.11.22.

import Foundation

extension PackageCreator {
  func openXcode() throws {
    do {
      guard let dir = dir, let name = names[0] else { return }
      
      try shell(
        "cd \(dir.appending(name).path()) && " +
        "xed ."
      )
    } catch {
      throw Failure.openingXcode(error)
    }
  }
}
