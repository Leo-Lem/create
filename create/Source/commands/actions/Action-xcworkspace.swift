// Created by Leopold Lemmermann on 29.05.23.

extension Action {
  static func xcworkspace(at path: String, fileRefs: [String]) -> Set<Self> {
    let file = "xcode/.xcworkspace"
    return [
      .download(file),
      .stage(file, rename: path),
      .replace("<#WORKSPACE_FILE_REFS#>", replacement: fileRefs.map {
        "<FileRef location = \"group:\($0)\"></FileRef>"
      }
      .joined(separator: "\n"))
    ]
  }
}
