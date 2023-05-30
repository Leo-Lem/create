// Created by Leopold Lemmermann on 29.05.23.

extension Action {
  static func testplan(
    path: String,
    targets: [(name: String, parallelizable: Bool)],
    coverageTargets: [String]
  ) -> [Action] {
    let file = "xcode/.xctestplan"
    return [
      .download(file),
      .stageCopy(file, rename: "\(path).xctestplan"),
      .replace("<#TESTPLAN_COVERAGE_TARGETS#>", replacement: targets.map(testplanTarget).joined(separator: ",\n")),
      .replace("<#TESTPLAN_TARGETS#>", replacement: coverageTargets.map(testplanCoverageTarget).joined(separator: ",\n"))
    ]
  }

  static func testplanTarget(name: String, parallelizable: Bool) -> String {
    "{ \"parellelizable\": \(parallelizable), \"target\": { "
      + "\"containerPath\": \"container:<#SCHEME_CONTAINER#>\", \"identifier\": \"\(name)\", \"name\": \"\(name)\" } }"
  }

  static func testplanCoverageTarget(name: String) -> String {
    "{ \"containerPath\" : \"container:<#SCHEME_CONTAINER#>\", \"identifier\" : \"\(name)\", \"name\" : \"\(name)\" }"
  }
}
