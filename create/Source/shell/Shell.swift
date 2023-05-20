// Created by Leopold Lemmermann on 20.05.23.

import struct Foundation.URL

struct Shell {}

extension Shell {
  enum Error: Swift.Error {
    case running(Swift.Error)
    case fileHandle(Swift.Error)
    case failed(String?)
  }
}
