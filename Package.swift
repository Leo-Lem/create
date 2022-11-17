// swift-tools-version: 5.7

import PackageDescription

// MARK: - (TARGETS)

let core = Target.target(
  name: "CreatePackageCore"
)

let executable = Target.executableTarget(
  name: "CreatePackage",
  dependencies: [.target(name: core.name)]
)

let tests = Target.testTarget(
  name: "\(executable.name)Tests",
  dependencies: [.target(name: core.name)],
  path: "Tests"
)

// MARK: - (PACKAGE)

let package = Package(
  name: executable.name,
  platforms: [.macOS(.v13)],
  targets: [core, executable, tests]
)
