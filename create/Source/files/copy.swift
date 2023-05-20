// Created by Leopold Lemmermann on 21.05.23.

import struct Foundation.URL
import class Foundation.FileManager

extension Files {
  static func move(from origin: URL, to destination: URL) throws {
    try manager.moveItem(at: origin, to: destination)
  }
  
  static func moveAll(from origin: URL, to destination: URL) throws {
    print(origin)
    for url in try manager.contentsOfDirectory(at: origin, includingPropertiesForKeys: nil) {
      print(url)
      try move(from: url, to: destination.appending(component: url.lastPathComponent))
    }
  }
}
