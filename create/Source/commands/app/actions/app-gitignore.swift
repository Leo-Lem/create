// Created by Leopold Lemmermann on 29.05.23.

extension App.Actions {
  static func gitignore(at path: String) -> [Action] {
    let file = fileRef(".gitignore", isAbsolute: true)

    return [
      .stageCopy(".gitignore", rename: path),
      .replace("<#GITIGNORE_FILE_REF#>", replacement: file.ref),
      .replace("<#GITIGNORE_FILE_REF_ID#>", replacement: "\(file.id),")
    ]
  }
}
