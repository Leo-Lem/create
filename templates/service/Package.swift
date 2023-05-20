// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "<#Service#>",
  platforms: [.iOS(.v13), .macOS(.v10_15)]
)

// MARK: - (DEPENDENCIES)

// package.dependencies.append(.package(url: "<#URL#>", branch: "main"))

// MARK: - (TARGETS)

let service = Target.target(
  name: "<#Service#>",
  dependencies: []
)

let implementation = Target.target(
  name: "<#Implementation#>",
  dependencies: [.target(name: service.name)]
)

let tests = Target.target(
  name: "BaseTests",
  dependencies: [.target(name: service.name)],
  path: "Tests/BaseTests"
)

let mockTests = Target.testTarget(
  name: "Mock\(service.name)Tests",
  dependencies: [.target(name: tests.name)]
)

let implTests = Target.testTarget(
  name: "\(implementation.name)Tests",
  dependencies: [
    .target(name: implementation.name),
    .target(name: tests.name)
  ]
)

package.targets = [service, implementation, tests, mockTests, implTests]

// MARK: - (PRODUCTS)

package.products.append(.library(name: package.name, targets: [service.name, implementation.name]))
