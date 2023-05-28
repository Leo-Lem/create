// Created by <#NAME#> on <#DATE#>.

import ComposableArchitecture

struct AppReducer: ReducerProtocol {
  var body: some ReducerProtocol<State, Action> {
    Scope(state: \.hello, action: /Action.hello, child: Hello.init)

    Reduce { state, action in
      switch action {
      case .toggleIsActive: state.isActive.toggle()
      default: break
      }

      return .none
    }
  }
}

extension AppReducer {
  struct State: Equatable {
    var hello: Hello.State
    var isActive: Bool
  }
}

extension AppReducer {
  enum Action {
    case hello(Hello.Action)
    case toggleIsActive
  }
}
