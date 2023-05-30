// Created by Leopold Lemmermann on 30.05.23.

import ArgumentParser

extension App {
  func featurePackage() -> [Action] {
    [
      .replace("<#FEATURE_PACKAGE_REF#>", replacement: Action.xcworkspaceFileRef(path: "Feature"))
    ]
  }

  func addFeaturePackage() {
    let options = CreateCommandOptions(
      title: "Feature",
      path: general.path.appending(component: general.title),
      name: nil,
      readme: false,
      license: false,
      repo: false,
      open: false
    )

    Package(general: options, template: .tcaFeature, ci: false, swiftlintVersion: "5.8").run()
  }
}
