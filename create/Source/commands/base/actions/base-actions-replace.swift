// Created by Leopold Lemmermann on 31.05.23.

import struct Foundation.Date

extension BaseActions {
  static func replace(title: String, name: String?) throws -> [Action] {
    [
      .replace("<#TITLE#>", replacement: title),
      .replace("<#NAME#>", replacement: try name ?? Files.getName()),
      .replace("<#DATE#>", replacement: Date.now
        .formatted(Date.FormatStyle().year(.defaultDigits).month(.twoDigits).day(.twoDigits)))
    ]
  }
}
