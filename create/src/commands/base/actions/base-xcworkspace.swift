// Created by Leopold Lemmermann on 29.05.23.

extension BaseActions {
  static func xcworkspace(at path: String, fileRefs: [String]) -> [Action] {
    let file = "xcode/.xcworkspace"
    return [
      .download(file),
      .stage(file, rename: path),
      .replace("<#WORKSPACE_FILE_REFS#>", replacement: fileRefs.map(xcworkspaceFileRef).joined(separator: "\n"))
    ]
  }

  static func xcworkspaceFileRef(path: String) -> String {
    "<FileRef location = \"group:\(path)\"></FileRef>"
  }
}
