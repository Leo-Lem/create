// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser

struct GeneralFlags: ParsableArguments {
  @Flag(name: .shortAndLong, help: "Adds a README file. (default: true)") var readme = true
  @Flag(name: .shortAndLong, help: "Adds an MIT License. (default: true)") var license = true
  @Flag(name: .shortAndLong, help: "Initializes a git repository. (default: true)") var repository = true
}

struct CIFlag: ParsableArguments {
  @Flag(name: .shortAndLong, help: "Adds configuration for Github Actions CI. (default: true)") var ci = true
}
