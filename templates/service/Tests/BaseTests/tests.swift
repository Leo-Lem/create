@_exported @testable import <#Service#>
@_exported import XCTest

// !!!:  Subclass these tests and insert an implementation to 'service' in the setUp method.
open class BaseTests<S: <#Service#>>: XCTestCase {
  public var service: S!
}
