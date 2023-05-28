// Created by Leopold Lemmermann on 28.05.23.

import struct Foundation.URL

extension Package {
  func stage(from downloads: URL, to stage: URL) throws {
    try Template.package(template).moveAll(from: downloads, into: stage)

    try Template.xcscheme.move(
      from: downloads,
      to: try Files.create(at: stage.appending(components: ".swiftpm", "xcode", "xcshareddata", "xcschemes")),
      rename: "<#TITLE#>.xcscheme"
    )

    try Template.unitTestplan.move(
      from: downloads,
      to: stage.appending(component: "test"),
      rename: " <#TITLE#>.xctestplan"
    )

    if ci {
      try Template.githubCI.move(
        from: downloads,
        to: try Files.create(at: stage.appending(components: ".github", "workflows"))
      )
    }
  }
}
