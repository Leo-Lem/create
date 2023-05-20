// Created by Leopold Lemmermann on 20.05.23.

import struct Foundation.URL

extension Files {
  static func getTempDir(_ named: String) throws -> URL {
    let temp = manager.temporaryDirectory.appending(component: named)
    try? manager.removeItem(at: temp)
    try manager.createDirectory(at: temp, withIntermediateDirectories: true)
    return temp
  }
}
