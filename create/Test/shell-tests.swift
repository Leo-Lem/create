@testable import Create
import Foundation
import XCTest

final class ShellTests: XCTestCase {
  func test_givenArgumentsAreValid_whenDownloadingTemplates_thenFilesAreDownloaded() throws {
    let urls = try Shell.fetchTemplates(folders: "package", files: "README.md", "LICENSE")
    
    urls.forEach { XCTAssertTrue(FileManager.default.fileExists(atPath: $0.path())) }
  }
}
