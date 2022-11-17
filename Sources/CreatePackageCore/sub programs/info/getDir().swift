//	Created by Leopold Lemmermann on 16.11.22.

import Foundation

extension CreatePackage {
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
    if input.isEmpty {
      var url: URL = dir
      
      if dir.lastPathComponent == "leolem" {
        url = url
          .appending(component: "dev")
          .appending(component: "mob")
          .appending(component: "packages")
      }
      
      switch kind {
      case .library: url.append(component: "libraries")
      case .service: url.append(component: "services")
      }
      
      return url
    } else if
      FileManager.default.fileExists(atPath: input),
      var url = URL(string: input)
    {
      switch kind {
      case .library: url.append(component: "libraries")
      case .service: url.append(component: "services")
      }
      
      return url
    } else {
      return nil
    }
  }
}
