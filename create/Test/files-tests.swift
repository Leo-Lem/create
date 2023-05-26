// Created by Leopold Lemmermann on 21.05.23.

@testable import create
import Foundation
import XCTest

final class FilesTests: XCTestCase {
  func test_whenCreatingDirectory_thenOverridesOrCreates() {
    let url = URL(fileURLWithPath: NSTemporaryDirectory())
      .appendingPathComponent(UUID().uuidString)
    XCTAssertNoThrow(try Files.create(at: url))
    XCTAssertNoThrow(try Files.create(at: url))
  }
  
  func test_whenGettingTempDir_thenReturnsADirectory() {
    XCTAssertNoThrow(try Files.getTempDir("leolem.create.test"))
  }
  
  func test_whenGettingName_thenReturnsSomeName() throws {
    XCTAssertNotNil(try Files.getName())
  }
  
  func test_whenMovingFile_thenMoves() {
    let url = URL(fileURLWithPath: NSTemporaryDirectory())
      .appendingPathComponent(UUID().uuidString)
    let dest = URL(fileURLWithPath: NSTemporaryDirectory())
      .appendingPathComponent(UUID().uuidString)
    XCTAssertNoThrow(try Files.create(at: url))
    XCTAssertNoThrow(try Files.move(from: url, to: dest))
  
  }
  
  func test_whenMovingAllFilesInDir_thenMovesAll() {
    let url = URL(fileURLWithPath: NSTemporaryDirectory())
      .appendingPathComponent(UUID().uuidString)
    let dest = URL(fileURLWithPath: NSTemporaryDirectory())
      .appendingPathComponent(UUID().uuidString)
    XCTAssertNoThrow(try Files.create(at: url))
    XCTAssertNoThrow(try Files.create(at: dest))
    XCTAssertNoThrow(try Files.moveAll(in: url, to: dest))
  }
}

