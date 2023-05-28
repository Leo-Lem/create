// Created by Leopold Lemmermann on 28.05.23.

import Foundation

extension Replacement {
  static func title(_ title: String) -> Self { .replacement("<#TITLE#>", title) }

  static func name(_ name: String?) throws -> Self { .replacement("<#NAME#>", try name ?? Files.getName()) }

  static let date: Self = .replacement(
    "<#DATE#>", Date.now.formatted(Date.FormatStyle().day(.twoDigits).month(.twoDigits).year(.defaultDigits))
  )

  static let year: Self = .replacement("<#YEAR#>", Date.now.formatted(Date.FormatStyle().year(.defaultDigits)))
}

extension CreateCommand {
  func replace(in stage: URL) throws {
    var replacements  = [Replacement]()
    try add(replacements: &replacements)
    replacements.append(contentsOf: [.title(general.title), try .name(general.name), .date, .year])

    try replacements.forEach { try $0.replace(in: stage) }
  }
}
