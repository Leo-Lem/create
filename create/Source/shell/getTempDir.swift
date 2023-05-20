// Created by Leopold Lemmermann on 20.05.23.

import Foundation

extension Shell {
  static func getTempDir(_ named: String) throws -> URL {
    let temp = FileManager.default.temporaryDirectory.appending(component: named)
    try FileManager.default.removeItem(at: temp)
    try FileManager.default.createDirectory(at: temp, withIntermediateDirectories: true)
    return temp
  }
}
