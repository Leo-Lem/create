@testable import CreatePackageCore
import XCTest

final class PackageCreatorTests: XCTestCase {
  var creator: PackageCreator!
  
  override func setUp() {
    creator = PackageCreator()
  }
  
  func testKindInput() {
    for libInput in ["l", "library"] {
      XCTAssertEqual(creator.getKind(libInput), .library, "Input does not return library kind...")
    }
    
    for serviceInput in ["s", "service"] {
      XCTAssertEqual(creator.getKind(serviceInput), .service, "Input does not return service kind...")
    }
    
    for invalidInput in ["package", "something else"] {
      XCTAssertNil(creator.getKind(invalidInput), "Invalid input is accepted...")
    }
  }
  
  func testNameInput() {
    creator.kind = .library
    
    for validInput in ["SomeLibrary", "SomeOtherLibrary"] {
      XCTAssertEqual(creator.getName(validInput), validInput, "Valid input was declined...")
    }
    
    for invalidInput in [" ", "", "1input", "i--1"] {
      XCTAssertNil(creator.getName(invalidInput), "Invalid input was accepted...")
    }
                     
    for modifiedInput in [" SomeLibrary", "No motherfucker"] {
      XCTAssertNotNil(creator.getName(modifiedInput), "The input was declined...")
    }
    
    creator.kind = .service
    
    let input = "Creating"
    
    XCTAssertEqual(creator.getName(input), "\(input)Service", "The service suffix is not appended")
  }
  
  // !!!: these tests depend on the os they're executed on
  func testDirInput() {
    creator.names[0] = "SomeLibrary"
    creator.kind = .library
    
    // these paths should work macos
    for validInput in ["/Users/", "/Library/", "   \n", ""] {
      XCTAssertNotNil(creator.getDir(validInput), "Input \(validInput) does not resolve to url...")
    }
    
    for invalidInput in ["/NoDirectory/ ", ".adsleoks"] {
      XCTAssertNil(creator.getDir(invalidInput), "Invalid \(invalidInput) input resolves to url...")
    }
  }
}
