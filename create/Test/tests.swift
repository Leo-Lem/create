@testable import create
import XCTest

final class CreateTests: XCTestCase {
  func test_whenCreatingDefaultPackage_thenIsCreatedWithCorrectTitle() throws {
    let temp = try Files.getTempDir("leolem.create.test")
    let title = "TestPackage"

    let package = try XCTUnwrap(
      try Create.parseAsRoot(["package", "--no-open", "-t", title, "-p", temp.path()]) as? Package
    )
    
    XCTAssertEqual(package.title.title, "TestPackage")
    XCTAssertEqual(package.path.path, temp)
    
    package.run()
    
    XCTAssertTrue(FileManager.default.fileExists(atPath: temp.appending(component: title).path()))
  }
}
