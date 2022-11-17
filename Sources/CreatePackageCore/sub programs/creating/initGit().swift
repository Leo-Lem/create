//	Created by Leopold Lemmermann on 16.11.22.

import Foundation

extension CreatePackage {
  func initGit() throws {
    do {
      try shell(
        "cd \(dir.appendingPathComponent(names[0]).path()) && " +
        "git init && " +
        "git add . && " +
        "git commit -m 'Initial Commit.'"
      )
    } catch {
      throw Failure.initGit(error)
    }
  }
}
