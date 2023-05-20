import BaseTests

class Mock<#Service#>Tests: BaseTests<Mock<#Service#>> {
  override func setUp() { service = .mock }
}
