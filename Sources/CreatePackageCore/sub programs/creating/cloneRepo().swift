//	Created by Leopold Lemmermann on 16.11.22.

import Foundation

extension CreatePackage {
  func cloneRepo() throws {
    do {
      try shell(
        "cd '\(dir.path())' &&" +
        "git clone 'https://github.com/Leo-Lem/\(kind.template).git'")
    } catch {
      throw Failure.cloningTemplate(error)
    }
  }
}
