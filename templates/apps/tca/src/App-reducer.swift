// Created by <#NAME#> on <#DATE#>.

import ComposableArchitecture
import struct <#FEATURE_TITLE#>.<#FEATURE_TITLE#>

struct AppReducer: ReducerProtocol {
  var body: some ReducerProtocol<State, Action> {
    Scope(state: \.<#FEATURE_VARIABLE#>, action: /Action.<#FEATURE_VARIABLE#>, child: <#FEATURE_TITLE#>.init)

    Reduce { state, action in
      switch action {
      // TODO: add reducers
      default: break
      }

      return .none
    }
  }
}

// MARK: - (STATE)

extension AppReducer {
  struct State: Equatable {
    var <#FEATURE_VARIABLE#> = <#FEATURE_TITLE#>.State()
    // TODO: add state
  }
}

// MARK: - (ACTIONS)

extension AppReducer {
  enum Action {
    case <#FEATURE_VARIABLE#>(<#FEATURE_TITLE#>.Action)
    // TODO: add actions
  }
}
