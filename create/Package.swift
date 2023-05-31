// swift-tools-version: 5.8

import PackageDescription

let package = Package(
  name: "create",
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
  path: "src"
)

let tests: Target = .testTarget(
  name: "\(script.name)Tests",
  dependencies: [.target(name: script.name)],
  path: "test",
  exclude: ["create.xctestplan"]
)

package.targets = [script, tests]

// MARK: - (PRODUCTS)

package.products = [.executable(name: script.name, targets: [script.name])]
