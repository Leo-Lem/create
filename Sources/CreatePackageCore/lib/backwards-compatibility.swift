//	Created by Leopold Lemmermann on 17.11.22.

import Foundation

extension URL {
  func appending(_ component: String) -> Self {
    if #available(macOS 13.0, *) {
      return appending(component: component)
    } else {
      return appendingPathComponent(component)
    }
  }
  
  mutating func append(_ component: String) {
    if #available(macOS 13.0, *) {
      append(component: component)
    } else {
      appendPathComponent(component)
    }
  }
  
  func path() -> String {
    if #available(macOS 13.0, *) {
      return path(percentEncoded: true)
    } else {
      return path
    }
  }
}

extension String {
  func replacing(match: String, with replacement: String) -> String {
    if #available(macOS 13.0, *) {
      return replacing(" ", with: "")
    } else {
      return replacingOccurrences(of: " ", with: "")
    }
  }
}
