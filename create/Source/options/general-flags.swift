// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser

struct GeneralFlags: ParsableArguments {
  @Flag(name: .long, inversion: .prefixedNo, help: "Adds a README file.") var readme = true
  @Flag(name: .long, inversion: .prefixedNo, help: "Adds an MIT license.") var license = true
  @Flag(name: .long, inversion: .prefixedNo, help: "Initializes a git repository.") var repo = true
}
