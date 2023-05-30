// Created by <#NAME#> on <#DATE#>.

import XCTest

@MainActor
final class <#TITLE#>UITests: XCTestCase {
  private var app: XCUIApplication!

  override func setUp() {
    continueAfterFailure = false

    app = XCUIApplication()
    app.launch()
  }

  override func tearDown() {
    app.terminate()
    app = nil
  }

  func testLaunchPerformance() throws {
    measure(metrics: [XCTApplicationLaunchMetric()]) {
      XCUIApplication().launch()
    }
  }

  func test<#Feature#>_given<#Precondition#>_when<#Action#>_then<#Outcome#>() throws {
    // TODO: Add UI tests for <#TITLE#>
  }
}
