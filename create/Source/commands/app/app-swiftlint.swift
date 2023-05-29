// Created by Leopold Lemmermann on 29.05.23.

extension App {
  func swiftlintActions() -> Set<Action> {
    let buildphaseId = id()
    let script = "export PATH=\\\"$PATH:/opt/homebrew/bin\\\"\\n"
      + "if which swiftlint > /dev/null; then\\n"
      + "  swiftlint\\n"
      + "else\\n"
      + "  echo \\\"warning: Swiftlint not installed.\\\"\\n"
      + "fi\\n"
    let replacement = "\(buildphaseId) = {isa = PBXShellScriptBuildPhase; buildActionMask = 2147483647; alwaysOutOfDate = 1;"
      + "files = (); inputFileListPaths = (); inputPaths = (); outputFileListPaths = (); outputPaths = (); "
      + "runOnlyForDeploymentPostprocessing = 0; "
      + "shellPath = /bin/zsh; shellScript = \"\(script)\";"
      + "};"

    let file = fileRef(".swiftlint.yml", isAbsolute: true)

    return Set([
      .download(".swiftlint.yml"),
      .stage(".swiftlint.yml", rename: "app/.swiftlint.yml"),
      .replace("<#SWIFTLINT_BUILDPHASE#>", replacement: replacement),
      .replace("<#SWIFTLINT_BUILDPHASE_ID#>", replacement: "\(buildphaseId),"),
      .replace("<#SWIFTLINT_CONFIG_FILE_REF#>", replacement: file.ref),
      .replace("<#SWIFTLINT_CONFIG_FILE_REF_ID#>", replacement: "\(file.id),")
    ])
  }
}
