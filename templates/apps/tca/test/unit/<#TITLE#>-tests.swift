// Created by <#NAME#> on <#DATE#>.

@testable import <#TITLE#>
import XCTest

@MainActor
final class <#TITLE#>Tests: XCTestCase {
  func test<#Feature#>_given<#Precondition#>_when<#Action#>_then<#Outcome#>() async throws {
    <#Given#>

    let store = TestStore(initialState: <#State#>, reducer: <#Reducer#>()) {
      <#Dependencies#>
    }

    await store.send(<#Action#>) { <#New State#> }
    await store.receive(<#Action#>) { <#New State#> }
  }
}
