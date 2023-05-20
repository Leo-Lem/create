// swift-tools-version: 5.8

import PackageDescription

let package = Package(
  name: "Create",
  platforms: [.macOS(.v13)]
)

// MARK: - (DEPENDENCIES)

package.dependencies = [
  .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMajor(from: "1.0.0"))
]

// MARK: - (TARGETS)

let script: Target = .executableTarget(
  name: package.name,
  dependencies: [
    .product(name: "ArgumentParser", package: "swift-argument-parser")
  ],
  path: "Source"
)

let tests: Target = .testTarget(
  name: "\(script.name)Tests",
  dependencies: [.target(name: script.name)],
  path: "Test"
)

package.targets = [script, tests]

// MARK: - (PRODUCTS)

package.products.append(.executable(name: script.name, targets: [script.name]))
