// Created by Leopold Lemmermann on 31.05.23.

import struct Foundation.URL

extension CreateCommand {
  func stage(_ actions: [Action], from templates: URL) throws -> URL {
    let stage = try Files.getTempDir("leolem.create.staging")

    try actions.compactMap(\.stagePath).forEach { name, rename, copy, inDir in
      let origin = templates.appending(path: name), destination = stage.appending(path: rename ?? name)

      if copy {
        try Files.copy(from: origin, to: destination)
      } else if inDir {
        try Files.moveAll(in: origin, to: stage.appending(path: rename ?? ""))
      } else {
        try Files.move(from: origin, to: destination)
      }
    }

    return stage
  }

  func unstage(from stage: URL, to project: URL) throws {
    try Files.create(at: project)
    try Files.moveAll(in: stage, to: project)
  }
}
