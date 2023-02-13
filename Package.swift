// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "Create",
  platforms: [.macOS(.v10_13)]
)

// MARK: - (DEPENDENCIES)

package.dependencies
  .append(.package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.0.0")))

// MARK: - (TARGETS)

let script: Target = .executableTarget(
  name: "CreateScript",
  dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")],
  path: "Sources"
)

let tests: Target = .testTarget(
  name: "\(script.name)Tests",
  dependencies: [.target(name: script.name)],
  path: "Tests"
)

package.targets = [script, tests]

// MARK: - (PRODUCTS)

package.products.append(.executable(name: script.name, targets: [script.name]))
