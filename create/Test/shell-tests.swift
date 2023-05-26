// Created by Leopold Lemmermann on 20.05.23.

@testable import create
import Foundation
import XCTest

final class ShellTests: XCTestCase {
  func test_givenArgumentsAreValid_whenDownloadingTemplates_thenFilesAreDownloaded() throws {
    let url = try Shell.fetchTemplates(folders: [.package], files: [.readme, .license])
    
    XCTAssertTrue(FileManager.default.fileExists(atPath: url.appending(component: Template.package.rawValue).path()))
    XCTAssertTrue(FileManager.default.fileExists(atPath: url.appending(component: Template.readme.rawValue).path()))
    XCTAssertTrue(FileManager.default.fileExists(atPath: url.appending(component: Template.license.rawValue).path()))
  }
  
  func test_givenFolderExists_whenSettingUpRepo_thenCreatesGitFolderAndInitialCommit() throws {
    let temp = FileManager.default.temporaryDirectory.appending(component: "create-git-demo")
    try? FileManager.default.removeItem(at: temp)
    try FileManager.default.createDirectory(at: temp, withIntermediateDirectories: true)
    
    try Shell.setupRepo(at: temp)
    
    XCTAssertTrue(FileManager.default.fileExists(atPath: temp.appending(component: ".git").path()))
    
    let output = try Shell.run("cd \(temp.path())", "git log --oneline")
    
    XCTAssertNotNil(output)
  }
  
  func test_givenFileExists_whenReplacingNames_thenIsRenamed() throws {
    let temp = FileManager.default.temporaryDirectory.appending(component: "create-replace-names")
    try? FileManager.default.removeItem(at: temp)
    try FileManager.default.createDirectory(at: temp, withIntermediateDirectories: true)
    
    let file = temp.appending(component: "test.txt")
    try "test".write(to: file, atomically: true, encoding: .utf8)
    
    try Shell.replaceNames("test", in: temp, with: "replaced")
    
    let newFile = temp.appending(component: "replaced.txt")
    XCTAssertTrue(FileManager.default.fileExists(atPath: newFile.path()))
    XCTAssertFalse(FileManager.default.fileExists(atPath: file.path()))
  }
  
  func test_givenFileExistsAndHasContent_whenReplacingInFiles_thenReflectsChanges() throws {
    let temp = FileManager.default.temporaryDirectory.appending(component: "create-replace-in-files")
    try? FileManager.default.removeItem(at: temp)
    try FileManager.default.createDirectory(at: temp, withIntermediateDirectories: true)
    
    let file = temp.appending(component: "test.txt")
    try "test".write(to: file, atomically: true, encoding: .utf8)
    
    try Shell.replaceInFiles("test", in: temp, with: "replaced")
    
    let content = try String(contentsOf: file, encoding: .utf8)
    XCTAssertEqual(content, "replaced")
  }
}
