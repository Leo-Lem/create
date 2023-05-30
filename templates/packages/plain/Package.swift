// swift-tools-version: 5.8

import PackageDescription

let package = Package(
  name: "<#TITLE#>"
)

// MARK: - (DEPENDENCIES)

package.dependencies = []

// MARK: - (TARGETS)

let src = Target.target(
  name: package.name,
  path: "src"
)

let test = Target.testTarget(
  name: "\(src.name)Tests",
  dependencies: [.target(name: src.name)],
  path: "test"
)

package.targets = [src, test]

// MARK: - (PRODUCTS)

package.products = [.library(name: package.name, targets: [src.name])]
