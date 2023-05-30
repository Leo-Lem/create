// Created by Leopold Lemmermann on 29.05.23.

extension App.Actions {
  static func xcworkspace(general: BaseOptions) -> [Action] {
    var refs = ["<#TITLE#>/<#TITLE#>.xcodeproj"]

    if general.repo { refs.append(".gitignore") }
    if general.readme { refs.append("README.md") }
    if general.license { refs.append("LICENSE") }

    return BaseActions.xcworkspace(at: "<#TITLE#>.xcworkspace", fileRefs: refs)
  }
}
