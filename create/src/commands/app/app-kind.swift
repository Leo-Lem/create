// Created by Leopold Lemmermann on 31.05.23.

import protocol ArgumentParser.EnumerableFlag

extension App {
  enum Kind: String, EnumerableFlag {
    case simple
    case tca
  }
}
