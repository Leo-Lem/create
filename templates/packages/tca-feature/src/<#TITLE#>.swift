// Created by <#NAME#> on <#DATE#>.

import ComposableArchitecture

public struct <#TITLE#>: ReducerProtocol {
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
      // TODO: add reducer for <#TITLE#>
    default: break
    }

    return .none
  }
}

// MARK: - (STATE)

public extension <#TITLE#> {
  struct State: Equatable {
    // TODO: add state for <#TITLE#>
  }
}

// MARK: - (ACTIONS)

public extension <#TITLE#> {
  enum Action {
    // TODO: add actions for <#TITLE#>
  }
}
