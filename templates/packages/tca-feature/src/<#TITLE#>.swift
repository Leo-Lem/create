// Created by <#NAME#> on <#DATE#>.

import ComposableArchitecture

public struct <#TITLE#>: ReducerProtocol {
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    // TODO: add reducer for <#TITLE#>

    switch action {
    default: break
    }

    return .none
  }

  public init() {}
}

// MARK: - (STATE)

public extension <#TITLE#> {
  struct State: Equatable {
    // TODO: add state for <#TITLE#>

    public init() {}
  }
}

// MARK: - (ACTIONS)

public extension <#TITLE#> {
  enum Action {
    // TODO: add actions for <#TITLE#>
  }
}
