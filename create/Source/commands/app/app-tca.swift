// Created by Leopold Lemmermann on 29.05.23.

extension App {
  func tcaActions() -> Set<Action> {
    let ref = packageRef(url: "https://github.com/pointfreeco/swift-composable-architecture", minVersion: "0.53.2")
    let dep = packageDep(refId: ref.id, name: "ComposableArchitecture")
    let build = buildRef(dep.id, isProduct: true)

    return [
      .replace("<#TCA_REF#>", replacement: ref.ref),
      .replace("<#TCA_REF_ID#>", replacement: ref.id),
      .replace("<#TCA_DEP#>", replacement: dep.ref),
      .replace("<#TCA_DEP_ID#>", replacement: dep.id),
      .replace("<#TCA_BUILD_REF#>", replacement: build.ref),
      .replace("<#TCA_BUILD_REF_ID#>", replacement: build.id)
    ]
  }
}
