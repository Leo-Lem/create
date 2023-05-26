// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser

struct TitleOption: ParsableArguments {
  @Option(name: .shortAndLong, help: "The title of your project.") var title: String
}
