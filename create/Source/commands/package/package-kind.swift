// Created by Leopold Lemmermann on 31.05.23.

import protocol ArgumentParser.EnumerableFlag

extension Package {
  enum Kind: String, EnumerableFlag {
    case plain
    case tcaFeature = "tca-feature"
  }
}

