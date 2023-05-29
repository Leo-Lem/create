// Created by Leopold Lemmermann on 29.05.23.

import struct Foundation.UUID

extension App {
  func xcodeproj(name: String) -> Set<Action> {
    let file = "xcode/.xcodeproj"

    var config = [(id: String, ref: String)]()
    if general.repo { config.append(fileRef(".gitignore", isAbsolute: true)) }
    if swiftlint { config.append(fileRef(".swiftlint.yml", isAbsolute: true)) }

    let src = [fileRef("App-reducer.swift"), fileRef("App-view.swift"), fileRef("App")]
    let srcBuild = src.map { buildRef($0.id) }

    let tcaRef = packageRef(url: "https://github.com/pointfreeco/swift-composable-architecture", minVersion: "0.53.2")
    let tcaDep = packageDep(refId: tcaRef.id, name: "ComposableArchitecture")
    let tcaBuild = buildRef(tcaDep.id, isProduct: true)

    return [
      .download(file),
      .stage(file, rename: "\(name).xcodeproj"),
      .replace("<#ORGANISATION#>", replacement: organisation),
      .replace("<#TEAM_ID#>", replacement: teamId ?? "YOUR_TEAM_ID"),
      .replace("<#PROJECT_FILE_REFS#>", replacement: (src + config).map(\.ref).joined(separator: "\n")),
      .replace("<#PROJECT_SRC_FILE_REF_IDS#>", replacement: src.map(\.id).joined(separator: ",\n")),
      .replace("<#PROJECT_CONFIG_CHILD_IDS#>", replacement: config.map(\.id).joined(separator: ",\n")),
      .replace("<#PROJECT_PACKAGE_REFS#>", replacement: tcaRef.ref),
      .replace("<#PROJECT_PACKAGE_REF_IDS#>", replacement: tcaRef.id),
      .replace("<#PROJECT_PACKAGE_DEPS#>", replacement: tcaDep.ref),
      .replace("<#PROJECT_PACKAGE_DEP_IDS#>", replacement: tcaDep.id),
      .replace("<#PROJECT_BUILD_REFS#>", replacement: (srcBuild + [tcaBuild]).map(\.ref).joined(separator: "\n")),
      .replace("<#PROJECT_PACKAGE_BUILD_IDS#>", replacement: tcaBuild.id)
    ]
  }

  func id() -> String { UUID().uuidString.replacing("-", with: "") }

  private func fileRef(_ path: String, isAbsolute: Bool = false) -> (id: String, ref: String) {
    let id = id()
    return (
      id,
      "\(id) = {isa = PBXFileReference; path = \(path); sourceTree = \(isAbsolute ? "SOURCE_ROOT" : "\"<group\"");};"
    )
  }

  private func buildRef(_ fileRefId: String, isProduct: Bool = false) -> (id: String, ref: String) {
    let id = id()
    return (
      id,
      "\(id) = {isa = PBXBuildFile; \(isProduct ? "productRef" : "fileRef") = \(fileRefId);};"
    )
  }

  private func packageRef(url: String, minVersion: String) -> (id: String, ref: String) {
    let id = id()
    return (
      id,
      "\(id) = { isa = XCRemoteSwiftPackageReference; "
        + "repositoryURL = \"\(url)\"; "
        + "requirement = {kind = upToNextMajorVersion; minimumVersion = \(minVersion);};"
        + "};"
    )
  }

  private func packageDep(refId: String, name: String) -> (id: String, ref: String) {
    let id = id()
    return (id, "\(id) = {isa = XCSwiftPackageProductDependency; package = \(refId); productName = \(name);};")
  }
}
