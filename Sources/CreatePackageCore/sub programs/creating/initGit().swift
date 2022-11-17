//	Created by Leopold Lemmermann on 16.11.22.

import Foundation

extension PackageCreator {
  func initGit() throws {
    do {
      guard let dir = dir, let name = names[0] else { return }
      
      try shell(
        "cd \(dir.appendingPathComponent(name).path()) && " +
        "git init && " +
        "git add . && " +
        "git commit -m 'Initial Commit.'"
      )
    } catch {
      throw Failure.initGit(error)
    }
  }
}
