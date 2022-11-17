//	Created by Leopold Lemmermann on 16.11.22.

import Foundation

extension CreatePackage {
  func openXcode() throws {
    do {
      try shell(
        "cd \(dir.appending(component: names[0]).path()) &&" +
        "xed ."
      )
    } catch {
      throw Failure.openingXcode(error)
    }
  }
}
