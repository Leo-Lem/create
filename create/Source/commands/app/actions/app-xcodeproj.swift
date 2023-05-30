// Created by Leopold Lemmermann on 29.05.23.

import struct Foundation.UUID

extension App.Actions {
  static func xcodeproj(name: String, organisation: String) -> [Action] {
    let file = "xcode/.xcodeproj"

    let src = [fileRef("App-reducer.swift"), fileRef("App-view.swift"), fileRef("App.swift")]
    let srcBuild = src.map { buildRef($0.id) }

    return [
      .download(file),
      .stage(file, rename: "\(name).xcodeproj"),
      .replace("<#ORGANISATION#>", replacement: organisation),
      .replace("<#PROJECT_FILE_REFS#>", replacement: src.map(\.ref).joined(separator: "\n")),
      .replace("<#PROJECT_SRC_FILE_REF_IDS#>", replacement: src.map(\.id).joined(separator: ",\n")),
      .replace("<#PROJECT_BUILD_REFS#>", replacement: srcBuild.map(\.ref).joined(separator: "\n")),
      .replace("<#PROJECT_BUILD_REF_IDS#>", replacement: srcBuild.map(\.id).joined(separator: ",\n"))
    ]
  }

  static func id() -> String { UUID().uuidString.replacing("-", with: "") }

  static func fileRef(_ path: String, isAbsolute: Bool = false) -> (id: String, ref: String) {
    let id = id()
    return (
      id,
      "\(id) = {isa = PBXFileReference; path = \(path); sourceTree = \(isAbsolute ? "SOURCE_ROOT" : "\"<group>\"");};"
    )
  }

  static func buildRef(_ fileRefId: String, isProduct: Bool = false) -> (id: String, ref: String) {
    let id = id()
    return (
      id,
      "\(id) = {isa = PBXBuildFile; \(isProduct ? "productRef" : "fileRef") = \(fileRefId);};"
    )
  }

  static func packageRef(url: String, minVersion: String) -> (id: String, ref: String) {
    let id = id()
    return (
      id,
      "\(id) = { isa = XCRemoteSwiftPackageReference; "
        + "repositoryURL = \"\(url)\"; "
        + "requirement = {kind = upToNextMajorVersion; minimumVersion = \(minVersion);};"
        + "};"
    )
  }

  static func packageDep(refId: String?, name: String) -> (id: String, ref: String) {
    let id = id()

    if let refId {
      return (id, "\(id) = {isa = XCSwiftPackageProductDependency; package = \(refId); productName = \(name);};")
    } else {
      return (id, "\(id) = {isa = XCSwiftPackageProductDependency; productName = \(name);};")
    }
  }
}
