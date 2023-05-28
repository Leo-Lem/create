// Created by Leopold Lemmermann on 28.05.23.

import struct Foundation.UUID

extension Replacement {
  static func xcodeprojTCA(_ general: CreateCommandOptions, swiftlint: Bool) -> Replacement {
    var children = [XcodeprojChild]()
    var configChildIds = [String]()

    if general.repo {
      let id = XcodeprojChild.generateId()
      children += [.fileRef(id, path: Template.gitignore.path, sourceTree: .project)]
      configChildIds.append(id)
    }

    if swiftlint {
      let id = XcodeprojChild.generateId()
      children += [.fileRef(id, path: Template.swiftlint.path, sourceTree: .project)]
      configChildIds.append(id)

      let scriptId = XcodeprojChild.generateId()
      children += [
        .scriptId(scriptId),
        .script(scriptId, script: "export PATH=\\\"$PATH:/opt/homebrew/bin\\\"\\n"
          + "if which swiftlint > /dev/null; then\\n"
          + "  swiftlint\\n"
          + "else\\n"
          + "  echo \\\"warning: Swiftlint not installed.\\\"\\n"
          + "fi\\n")
      ]
    }

    let refId = XcodeprojChild.generateId()
    children += [
      .packageRefId(refId),
      .packageRef(refId, url: "https://github.com/pointfreeco/swift-composable-architecture", minVersion: "0.53.2")
    ]

    let depId = XcodeprojChild.generateId()
    let buildId = XcodeprojChild.generateId()
    children += [
      .packageDepId(depId),
      .packageDep(depId, ref: refId, name: "ComposableArchitecture"),
      .buildRef(buildId, ref: depId, isProduct: true),
      .packageBuildId(buildId)
    ]

    let replacements = XcodeprojChild.Match.allCases
      .map { match in
        Replacement.replacement(
          match.rawValue, children.filter { $0.match == match }.map(\.replacement).joined(separator: match.separator)
        )
      }

    return .replacements(
      replacements
        + [.replacement("<#CONFIG_CHILD_IDS#>", configChildIds.joined(separator: ",\n"))]
    )
  }
}

enum XcodeprojChild {
  case buildRef(_ id: String, ref: String, isProduct: Bool = false)
  case fileRef(_ id: String, path: String, sourceTree: SourceTree)
  case packageRef(_ id: String, url: String, minVersion: String)
  case packageDep(_ id: String, ref: String, name: String)
  case script(_ id: String, script: String)
  case packageRefId(_ id: String)
  case packageDepId(_ id: String)
  case scriptId(_ id: String)
  case packageBuildId(_ id: String)
}

extension XcodeprojChild {
  static func generateId() -> String { UUID().uuidString.replacing("-", with: "") }

  var match: Match {
    switch self {
    case .buildRef: return .buildRef
    case .fileRef: return .fileRef
    case .packageRef: return .packageRef
    case .packageDep: return .packageDep
    case .script: return .script
    case .packageRefId: return .packageRefId
    case .packageDepId: return .packageDepId
    case .scriptId: return .scriptId
    case .packageBuildId: return .packageBuildId
    }
  }

  var replacement: String {
    switch self {
    case let .buildRef(id, ref, isProduct):
      return "\(id) = {isa = PBXBuildFile; \(isProduct ? "productRef" : "fileRef") = \(ref);};"
    case let .fileRef(id, path, sourceTree):
      return "\(id) = {isa = PBXFileReference; path = \(path); sourceTree = \(sourceTree.rawValue);};"
    case let .packageRef(id, url, minVersion):
      return "\(id) = { isa = XCRemoteSwiftPackageReference; "
        + "repositoryURL = \"\(url)\"; "
        + "requirement = {kind = upToNextMajorVersion; minimumVersion = \(minVersion);};"
        + "};"
    case let .packageDep(id, ref, name):
      return "\(id) = {isa = XCSwiftPackageProductDependency; package = \(ref); productName = \(name);};"
    case let .script(id, script):
      return "\(id) = {isa = PBXShellScriptBuildPhase; buildActionMask = 2147483647; alwaysOutOfDate = 1;"
        + "files = ();inputFileListPaths = (); inputPaths = (); outputFileListPaths = (); outputPaths = (); "
        + "runOnlyForDeploymentPostprocessing = 0; "
        + "shellPath = /bin/zsh; shellScript = \"\(script)\";"
        + "};"
    case let .scriptId(id), let .packageDepId(id), let .packageRefId(id), let .packageBuildId(id):
      return id
    }
  }
}

extension XcodeprojChild {
  enum SourceTree: String {
    case project = "SOURCE_ROOT"
    case group = "\"<group>\""
  }
}

extension XcodeprojChild {
  enum Match: String, CaseIterable {
    case buildRef = "<#PROJECT_BUILD_REFS#>"
    case fileRef = "<#PROJECT_FILE_REFS#>"
    case packageRef = "<#PROJECT_PACKAGE_REFS#>"
    case packageDep = "<#PROJECT_PACKAGE_DEPS#>"
    case script = "<#PROJECT_SCRIPT_BUILDPHASES#>"
    case scriptId = "<#PROJECT_SCRIPT_BUILDPHASE_IDS#>"
    case packageDepId = "<#PROJECT_PACKAGE_DEP_IDS#>"
    case packageRefId = "<#PROJECT_PACKAGE_REF_IDS#>"
    case packageBuildId = "<#PROJECT_PACKAGE_BUILD_IDS#>"

    var separator: String {
      switch self {
      case .packageDepId, .packageRefId, .scriptId, .script: return ",\n"
      default: return "\n"
      }
    }
  }
}
