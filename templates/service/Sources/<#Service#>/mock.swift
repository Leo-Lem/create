public extension <#Service#> where Self == Mock<#Service#> {
  static var mock: Mock<#Service#> { Mock<#Service#>() }
}

open class Mock<#Service#>: <#Service#> {
  public init() {}
}
