// Created by Leopold Lemmermann on 31.05.23.

extension App {
  func addFeature() {
    let options = BaseOptions(
      title: featureName, path: general.path.appending(component: general.title),
      name: nil, readme: false, license: false, repo: false, open: false
    )

    Package(general: options, template: .tcaFeature, ci: false).run()
  }
}
