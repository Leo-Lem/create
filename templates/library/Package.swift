// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "<#Library#>",
  platforms: [.iOS(.v13), .macOS(.v10_15)]
)

// MARK: - (TARGETS)

let lib = Target.target(
  name: "<#Library#>",
  path: "Sources"
)

let tests = Target.testTarget(
  name: "\(lib.name)Tests",
  dependencies: [.target(name: lib.name)],
  path: "Tests"
)

package.targets = [lib, tests]

// MARK: - (PRODUCTS)

package.products.append(.library(name: package.name, targets: [lib.name]))
