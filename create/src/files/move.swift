// Created by Leopold Lemmermann on 21.05.23.

import class Foundation.FileManager
import struct Foundation.URL

extension Files {
  static func move(from origin: URL, to destination: URL) throws {
    try? manager.createDirectory(at: destination.deletingLastPathComponent(), withIntermediateDirectories: true)
    try manager.moveItem(at: origin, to: destination)
  }

  static func moveAll(in origin: URL, to destination: URL) throws {
    for url in try manager.contentsOfDirectory(at: origin, includingPropertiesForKeys: nil) {
      try move(from: url, to: destination.appending(component: url.lastPathComponent))
    }
  }
}
