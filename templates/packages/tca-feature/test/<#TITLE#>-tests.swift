// Created by <#NAME#> on <#DATE#>.

@testable import <#TITLE#>
import ComposableArchitecture
import XCTest

@MainActor
final class <#TITLE#>Tests: XCTestCase {
  // TODO: Add <#TITLE#>'s unit tests

  func test<#Feature#>_given<#Precondition#>_when<#Action#>_then<#Outcome#>() async throws {
    <#Given#>

    let store = TestStore(initialState: <#State#>, reducer: <#TITLE#>()) {
      <#Dependencies#>
    }

    await store.send(<#Action#>) { <#New State#> }
    await store.receive(<#Action#>) { <#New State#> }
  }
}
