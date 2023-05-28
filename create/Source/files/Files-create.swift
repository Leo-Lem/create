// Created by Leopold Lemmermann on 20.05.23.

import struct Foundation.URL

extension Files {
  @discardableResult
  static func create(at url: URL) throws -> URL {
    try? manager.removeItem(at: url)
    try manager.createDirectory(at: url, withIntermediateDirectories: true)
    return url
  }
}
