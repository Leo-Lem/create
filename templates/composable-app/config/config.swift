import SwiftUI

enum Config {
  static let id = (
    bundle: "LeoLem.<#App#>",
    group: "group.LeoLem.<#App#>"
  )
  
  static let style = (
    fontName: "Helvetica",
    background: Color.black
  )

  static var containerURL: URL {
    FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Config.id.group)!
  }

  static var appname: String {
    (Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String)!
  }
}
