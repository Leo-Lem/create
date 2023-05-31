// Created by Leopold Lemmermann on 31.05.23.

import struct Foundation.URL

extension CreateCommand {
  func download(_ actions: [Action]) throws -> URL {
    let downloads = try Files.getTempDir("leolem.create.downloads")

    let templates = try Shell.fetchTemplates(actions.compactMap(\.downloadPath), to: downloads)

    return templates
  }
}
