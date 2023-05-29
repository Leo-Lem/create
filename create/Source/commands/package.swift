// Created by Leopold Lemmermann on 20.05.23.

import ArgumentParser

struct Package: CreateCommand {
  static let configuration = CommandConfiguration(abstract: "Creates a new package.")

  @OptionGroup var general: CreateCommandOptions

  @Flag(help: "The template to use.") var template: Kind = .plain

  @Flag(name: .long, inversion: .prefixedNo, help: "Adds Github Actions CI config.")
  var ci = true

  @Option(name: .long, help: "The Swift tools version.")
  var swiftToolsVersion = "5.8"

  @Option(name: .long, parsing: .upToNextOption, help: "The supported platforms.")
  var platforms = [".iOS(.v13)", ".macOS(.v10_15)"]

  func addActions(to actions: inout Set<Action>) {
    actions.insert(.download("packages/\(template.rawValue)"))
    actions.insert(.stageAll("packages/\(template.rawValue)"))

    actions.insert(.replace("<#SWIFT_TOOLS_VERSION#>", replacement: swiftToolsVersion))
    actions.insert(.replace("<#PLATFORMS#>", replacement: platforms.joined(separator: ", ")))

    let testPlanPath = "test/ Unit.xctestplan"
    actions.formUnion(Action.testplan(name: "unit", path: testPlanPath))
    actions.formUnion(Action.xcscheme(
      at: ".swiftpm/xcode/xcshareddata/xcschemes/<#TITLE#>.xcscheme",
      container: "",
      testPlans: [(path: testPlanPath, isDefault: true)]
    ))

    if ci {
      let ci = "ci/github-actions.yml"
      actions.insert(.download(ci))
      actions.insert(.stage(ci, rename: ".github/workflows/ci.yml"))
    }
  }
}

extension Package {
  enum Kind: String, EnumerableFlag {
    case plain
    case tcaFeature = "tca-feature"
  }
}
