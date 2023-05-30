// Created by Leopold Lemmermann on 30.05.23.

import ArgumentParser

extension App {
  func featurePackage() -> [Action] {
    let dep = packageDep(refId: nil, name: featureName)
    let build = buildRef(dep.id, isProduct: true)

    return [
      .replace("<#FEATURE_PACKAGE_FILE_REF#>", replacement: Action.xcworkspaceFileRef(path: featureName)),
      .replace("<#FEATURE_PACKAGE_DEP#>", replacement: dep.ref),
      .replace("<#FEATURE_PACKAGE_DEP_ID#>", replacement: dep.id + ","),
      .replace("<#FEATURE_PACKAGE_BUILD_REF#>", replacement: build.ref),
      .replace("<#FEATURE_PACKAGE_BUILD_REF_ID#>", replacement: build.id + ","),
      .replace("<#FEATURE_TITLE#>", replacement: featureName),
      .replace("<#FEATURE_VARIABLE#>", replacement: featureName.lowercased()),
      .replace(
        "<#FEATURE_PACKAGE_BUILD_ACTION_ENTRY#>", replacement: buildActionEntry(name: featureName, path: featureName)
      ),
      .replace("<#FEATURE_PACKAGE_TESTPLAN_TARGET#>", replacement: "," + Action.testplanTarget(
          name: "\(featureName)Tests", container: featureName, parallelizable: true
        )),
      .replace("<#FEATURE_PACKAGE_TESTPLAN_COVERAGE_TARGET#>", replacement: "," + Action.testplanCoverageTarget(
        name: featureName, container: featureName
      ))
    ]
  }

  func addFeaturePackage() {
    let options = BaseOptions(
      title: featureName, path: general.path.appending(component: general.title),
      name: nil, readme: false, license: false, repo: false, open: false
    )

    Package(general: options, template: .tcaFeature, ci: false, swiftlintVersion: "5.8").run()
  }
}
