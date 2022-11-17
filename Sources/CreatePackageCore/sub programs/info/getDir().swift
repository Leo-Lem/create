//	Created by Leopold Lemmermann on 16.11.22.

import Foundation

extension PackageCreator {
  func promptForDir() -> URL {
    while true {
      let input = readLine() ?? ""

      guard let url = getDir(input) else {
        print(feedback: "Can't find directory...")
        print(prompt: "Please try another one: (leave blank for home)")
        continue
      }
      return url
    }
  }

  func getDir(_ input: String) -> URL? {
    guard let kind = kind else { return nil }
    
    let fm = FileManager.default
    var url: URL = fm.homeDirectoryForCurrentUser
    
    switch input.trimmingCharacters(in: .whitespacesAndNewlines) {
    case let i where i.isEmpty:
      if url.lastPathComponent == "leolem" {
        url = url
          .appending("dev")
          .appending("mob")
          .appending("packages")
      }
    case let i where fm.fileExists(atPath: i):
      if let inputURL = URL(string: i) {
        url = inputURL
      } else {
        return nil
      }
    default:
      return nil
    }
    
    switch kind {
    case .library: url.append("libraries")
    case .service: url.append("services")
    }
    
    return url
  }
}
