// Created by Leopold Lemmermann on 27.05.23.

import Foundation

extension App {
  var replacements: [Replacement] {
    [
      .title(location.title),
      .name(),
      .date,
      .year,
      .organisation(options.organisation),
      .teamId(options.teamID),
      workspace
    ] + project
  }

  var workspace: Replacement {
    var files = [String]()

    if general.repo {
      files.append(".git")
      files.append(Template.gitignore.rawValue)
    }
    if general.readme { files.append(Template.readme.rawValue) }
    if general.license { files.append(Template.license.rawValue) }

    files.append("app/app.xcodeproj")
    files.append("res")

    return .other(
      match: "<#WORKSPACE_FILES#>",
      replacement: files.map { "<FileRef location = \"group:\($0)\"></FileRef>" }.joined(separator: "\n")
    )
  }

  var project: [Replacement] {
    var children = [PBXProjChild]()
    var configChildIds = [String]()

    if general.repo {
      let id = PBXProjChild.generateId()
      children += [.fileRef(id, path: Template.gitignore.rawValue, sourceTree: .project)]
      configChildIds.append(id)
    }

    if options.swiftlint {
      let id = PBXProjChild.generateId()
      children += [.fileRef(id, path: Template.swiftlint.rawValue, sourceTree: .project)]
      configChildIds.append(id)

      let scriptId = PBXProjChild.generateId()
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

    if options.tca {
      let refId = PBXProjChild.generateId()
      children += [
        .packageRefId(refId),
        .packageRef(refId, url: "https://github.com/pointfreeco/swift-composable-architecture", minVersion: "0.53.2")
      ]

      let depId = PBXProjChild.generateId()
      let buildId = PBXProjChild.generateId()
      children += [
        .packageDepId(depId),
        .packageDep(depId, ref: refId, name: "ComposableArchitecture"),
        .buildRef(buildId, ref: depId, isProduct: true),
        .packageBuildId(buildId)
      ]
    }

    let replacements = PBXProjChild.Match.allCases
      .map { match in
        Replacement.other(
          match: match.rawValue,
          replacement: children.filter { $0.match == match }.map(\.replacement).joined(separator: match.separator)
        )
      }

    return replacements + [.other(match: "<#CONFIG_CHILD_IDS#>", replacement: configChildIds.joined(separator: ",\n"))]
  }
}

enum PBXProjChild {
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

extension PBXProjChild {
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

extension PBXProjChild {
  enum SourceTree: String {
    case project = "SOURCE_ROOT"
    case group = "\"<group>\""
  }
}

extension PBXProjChild {
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
