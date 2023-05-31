// Created by Leopold Lemmermann on 29.05.23.

extension App.Actions {
  static func swiftlint(at path: String?) -> [Action] {
    let buildphaseId = id()
    let script = "if [[ \\\"$(uname -m)\\\" == arm64 ]]; then\\n"
      + "  export PATH=\\\"$PATH:/opt/homebrew/bin\\\"\\n"
      + "fi\\n\\n"
      + "if which swiftlint > /dev/null; then\\n"
      + "  swiftlint\\n"
      + "else\\n"
      + "  echo \\\"warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint\\\"\\n"
      + "fi\\n"
    let replacement = "\(buildphaseId) = {isa = PBXShellScriptBuildPhase; buildActionMask = 2147483647; alwaysOutOfDate = 1;"
      + "files = (); inputFileListPaths = (); inputPaths = (); outputFileListPaths = (); outputPaths = (); "
      + "runOnlyForDeploymentPostprocessing = 0; "
      + "shellPath = /bin/zsh; shellScript = \"\(script)\";"
      + "};"

    let file = fileRef(".swiftlint.yml", isAbsolute: true)

    return [
      .download(".swiftlint.yml"),
      .stage(".swiftlint.yml", rename: path),
      .replace("<#SWIFTLINT_BUILDPHASE#>", replacement: replacement),
      .replace("<#SWIFTLINT_BUILDPHASE_ID#>", replacement: "\(buildphaseId),"),
      .replace("<#SWIFTLINT_CONFIG_FILE_REF#>", replacement: file.ref),
      .replace("<#SWIFTLINT_CONFIG_FILE_REF_ID#>", replacement: "\(file.id),")
    ]
  }
}
