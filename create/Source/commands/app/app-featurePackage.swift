// Created by Leopold Lemmermann on 30.05.23.

import ArgumentParser

extension App {
  var featureName: String { "feature" }

  func featurePackage() -> [Action] {
    let dep = packageDep(refId: nil, name: featureName)
    let build = buildRef(dep.id)

    return [
      .replace("<#FEATURE_PACKAGE_FILE_REF#>", replacement: Action.xcworkspaceFileRef(path: featureName)),
      .replace("<#FEATURE_PACKAGE_DEP#>", replacement: dep.ref),
      .replace("<#FEATURE_PACKAGE_DEP_ID#>", replacement: dep.id + ","),
      .replace("<#FEATURE_PACKAGE_BUILD_REF#>", replacement: build.ref),
      .replace("<#FEATURE_PACKAGE_BUILD_REF_ID#>", replacement: build.id + ",")
    ]
  }

  func addFeaturePackage() {
    let options = CreateCommandOptions(
      title: featureName, path: general.path.appending(component: general.title),
      name: nil, readme: false, license: false, repo: false, open: false
    )

    Package(general: options, template: .tcaFeature, ci: false, swiftlintVersion: "5.8").run()
  }
}
