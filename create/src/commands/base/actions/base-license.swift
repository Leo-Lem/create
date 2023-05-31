// Created by Leopold Lemmermann on 31.05.23.

import struct Foundation.Date
import protocol ArgumentParser.ExpressibleByArgument

extension BaseActions {
  static func license(_ license: License) -> [Action] {
    let license = "licenses/\(license.rawValue)"
    return [
      .download(license),
      .stage(license, rename: "LICENSE"),
      .replace("<#YEAR#>", replacement: Date.now.formatted(Date.FormatStyle().year(.defaultDigits)))
    ]
  }
}

enum License: String, ExpressibleByArgument {
  case mit
  case bsd = "0bsd"
  case apache = "apache-2.0"
  case none
}
