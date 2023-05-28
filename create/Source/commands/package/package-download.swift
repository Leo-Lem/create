// Created by Leopold Lemmermann on 28.05.23.

extension Package {
  func add(templates: inout [Template]) throws {
    templates.append(.package(template))
    templates.append(.xcscheme)
    templates.append(.unitTestplan)
    if ci { templates.append(.githubCI) }
  }
}
