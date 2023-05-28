// Created by <#NAME#> on <#DATE#>.

import ComposableArchitecture

struct Hello: ReducerProtocol {
  public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
    switch action {
    case .setNameToWorld: state.name = "world"
    default: break
    }

    return .none
  }
}

extension Hello {
  struct State: Equatable {
    @BindingState public var name: String?
  }
}

extension Hello {
  enum Action: BindableAction {
    case setNameToWorld
    case binding(BindingAction<State>)
  }
}
