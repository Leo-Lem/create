// Created by Leopold Lemmermann on 29.05.23.

extension App {
  func gitignore() -> [Action] {
    let file = fileRef(".gitignore", isAbsolute: true)

    return [
      .stageCopy(".gitignore", rename: template == .tca ? "<#TITLE#>/.gitignore" : nil),
      .replace("<#GITIGNORE_FILE_REF#>", replacement: file.ref),
      .replace("<#GITIGNORE_FILE_REF_ID#>", replacement: "\(file.id),")
    ]
  }
}
