// Created by Leopold Lemmermann on 20.05.23.

import struct Foundation.URL

extension Files {
  static func getTempDir(_ named: String) throws -> URL {
    try create(at: manager.temporaryDirectory.appending(component: named))
  }
}
