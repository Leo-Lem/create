//	Created by Leopold Lemmermann on 16.11.22.

import Foundation

extension PackageCreator {
  func cloneRepo() throws {
    do {
      guard let dir = dir, let template = kind?.template else { return }
      
      try shell(
        "cd '\(dir.path())' && " +
        "git clone 'https://github.com/Leo-Lem/\(template).git'")
    } catch {
      throw Failure.cloningTemplate(error)
    }
  }
}
