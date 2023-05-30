@testable import create
import XCTest

final class CreateTests: XCTestCase {
  func testCreatingPackage_whenCreatingDefaultPackage_thenIsCreatedWithCorrectTitle() throws {
    let temp = try Files.getTempDir("leolem.create.test")
    let title = "TestPackage"

    let package = try XCTUnwrap(
      try Create.parseAsRoot(["package", title, "--no-open", "-p", temp.path()]) as? Package
    )

    XCTAssertEqual(package.general.title, title)
    XCTAssertEqual(package.general.project, temp.appending(component: title))

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
        "--tca",
        "-p", temp.path(),
        "-o", "test.leolem"
      ]) as? App
    )

    XCTAssertEqual(app.general.title, title)
    XCTAssertEqual(app.general.project, temp.appending(component: title))

    app.run()

    XCTAssertTrue(FileManager.default.fileExists(atPath: temp.appending(component: title).path()))
  }
}
