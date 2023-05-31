// Created by Leopold Lemmermann on 30.05.23.

extension App.Actions {
  static func feature(_ name: String) -> [Action] {
    let dep = packageDep(refId: nil, name: name)
    let build = buildRef(dep.id, isProduct: true)

    return [
      .replace("<#FEATURE_PACKAGE_FILE_REF#>", replacement: BaseActions.xcworkspaceFileRef(path: name)),
      .replace("<#FEATURE_PACKAGE_DEP#>", replacement: dep.ref),
      .replace("<#FEATURE_PACKAGE_DEP_ID#>", replacement: dep.id + ","),
      .replace("<#FEATURE_PACKAGE_BUILD_REF#>", replacement: build.ref),
      .replace("<#FEATURE_PACKAGE_BUILD_REF_ID#>", replacement: build.id + ","),
      .replace("<#FEATURE_TITLE#>", replacement: name),
      .replace("<#FEATURE_VARIABLE#>", replacement: name.lowercased()),
      .replace(
        "<#FEATURE_PACKAGE_BUILD_ACTION_ENTRY#>", replacement: BaseActions.buildActionEntry(name: name, path: name)
      ),
      .replace("<#FEATURE_PACKAGE_TESTPLAN_TARGET#>", replacement: "," + BaseActions.testplanTarget(
          name: "\(name)Tests", container: name, parallelizable: true
        )),
      .replace("<#FEATURE_PACKAGE_TESTPLAN_COVERAGE_TARGET#>", replacement: "," + BaseActions.testplanCoverageTarget(
        name: name, container: name
      ))
    ]
  }
}
