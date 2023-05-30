// Created by Leopold Lemmermann on 29.05.23.

extension Action {
  static func testplan(
    path: String,
    targets: [(name: String, container: String, parallelizable: Bool)],
    coverageTargets: [(name: String, container: String)]
  ) -> [Action] {
    let file = "xcode/.xctestplan"
    return [
      .download(file),
      .stageCopy(file, rename: "\(path).xctestplan"),
      .replaceIn(
        "<#TESTPLAN_TARGETS#>",
        replacement: targets.map(testplanTarget).joined(separator: ",\n"),
        path: "\(path).xctestplan"
      ),
      .replaceIn(
        "<#TESTPLAN_COVERAGE_TARGETS#>",
        replacement: coverageTargets.map(testplanCoverageTarget).joined(separator: ",\n"),
        path: "\(path).xctestplan"
      )
    ]
  }

  static func testplanTarget(name: String, container: String, parallelizable: Bool) -> String {
    "{ \"parallelizable\": \(parallelizable), \"target\": { "
      + "\"containerPath\": \"container:\(container)\", \"identifier\": \"\(name)\", \"name\": \"\(name)\" } }"
  }

  static func testplanCoverageTarget(name: String, container: String) -> String {
    "{ \"containerPath\" : \"container:\(container)\", \"identifier\" : \"\(name)\", \"name\" : \"\(name)\" }"
  }
}
