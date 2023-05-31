// Created by Leopold Lemmermann on 31.05.23.

extension BaseActions {
  static func gitignore(at path: String? = nil) -> [Action] {
    let gitignore = ".gitignore"
    
    return [.download(gitignore), .stageCopy(gitignore, rename: path)]
  }
}
