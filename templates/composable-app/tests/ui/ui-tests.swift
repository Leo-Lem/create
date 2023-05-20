import XCTest

final class <#App#>UITests: XCTestCase {
  var app: XCUIApplication!

  override func setUp() async throws {
    app = XCUIApplication()
    app.launch()

    // wait for app set up
  }

  func testExample() throws {}
}
