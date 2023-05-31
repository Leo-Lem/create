@testable import create
import XCTest

final class CreateTests: XCTestCase {
  func testCreatingPackage_whenCreatingDefaultPackage_thenIsCreatedWithCorrectTitle() throws {
    let temp = try Files.getTempDir("leolem.create.test")
    let title = "TestPackage"

    let package = try XCTUnwrap(
      try Create.parseAsRoot(["package", title, "--plain", "--no-open", "-p", temp.path()]) as? Package
    )

    XCTAssertEqual(package.location.title, title)
    XCTAssertEqual(package.location.project, temp.appending(component: title))

    package.run()

    XCTAssertTrue(FileManager.default.fileExists(atPath: temp.appending(component: title).path()))
  }

  func testCreatingApp_whenCreatingDefaultApp_thenIsCreatedWithCorrectTitle() throws {
    let temp = try Files.getTempDir("leolem.create.test")
    let title = "TestApp"

    let app = try XCTUnwrap(
      try Create.parseAsRoot([
        "app",
        title,
        "--no-open",
        "--simple",
        "-p", temp.path(),
        "-o", "test.leolem"
      ]) as? App
    )

    XCTAssertEqual(app.location.title, title)
    XCTAssertEqual(app.location.project, temp.appending(component: title))

    app.run()

    XCTAssertTrue(FileManager.default.fileExists(atPath: temp.appending(component: title).path()))
  }
}
