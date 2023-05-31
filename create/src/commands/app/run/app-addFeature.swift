// Created by Leopold Lemmermann on 31.05.23.

extension App {
  func addFeature() {
    let location = LocationOptions(title: feature, path: location.project)
    let options = BaseOptions(userName: nil, readme: false, license: .none, repo: false, open: false)

    Package(location: location, template: .tcaFeature, general: options, ci: false).run()
  }
}
