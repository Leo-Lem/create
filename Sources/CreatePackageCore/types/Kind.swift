//	Created by Leopold Lemmermann on 16.11.22.

extension PackageCreator {
  enum Kind: String {
    case library,
         service
  }
}

extension PackageCreator.Kind {
  var template: String {
    switch self {
    case .library:
      return "LibraryTemplate"
    case .service:
      return "ServiceTemplate"
    }
  }
}
