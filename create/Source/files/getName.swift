// Created by Leopold Lemmermann on 21.05.23.

import Foundation

extension Files {
  static func getName() throws -> String {
    NSFullUserName()
  }
}
