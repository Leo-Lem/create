// Created by Leopold Lemmermann on 21.05.23.

import class Foundation.FileManager
import struct Foundation.URL

extension Files {
  static func copy(from origin: URL, to destination: URL) throws {
    try manager.copyItem(at: origin, to: destination)
  }
}
