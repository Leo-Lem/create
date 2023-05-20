// swift-tools-version: 5.8

import PackageDescription

let package = Package(
  name: "<#Package#>",
  platforms: [.iOS(.v13), .macOS(.v10_15)]
)

// MARK: - (TARGETS)

let source = Target.target(
  name: "<#Package#>",
  path: "Source"
)

let test = Target.testTarget(
  name: "\(source.name)Tests",
  dependencies: [.target(name: source.name)],
  path: "Test"
)

package.targets = [source, test]

// MARK: - (PRODUCTS)

package.products.append(.library(name: package.name, targets: [source.name]))
