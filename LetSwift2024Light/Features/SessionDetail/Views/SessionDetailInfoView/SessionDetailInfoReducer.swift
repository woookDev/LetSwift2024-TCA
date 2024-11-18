//
//  SessionDetailInfoReducer.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import ComposableArchitecture

// MARK: - SessionDetailInfoReducer

@Reducer
struct SessionDetailInfoReducer {
    // MARK: - Initializer

    init() {}

    // MARK: - State

    @ObservableState
    struct State: Equatable {
        let viewModel: SessionDetailInfoViewModel
        
        @Shared(.fileStorage(.documentsDirectory.appendingPathComponent(FileStorageKeys.completedSessions.rawValue)))
        var completedSessions: Set<Int> = []
    }

    // MARK: - Action

    enum Action {
        case didTapCompleteButton
    }

    // MARK: - Reducer

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .didTapCompleteButton:
                if state.completedSessions.contains(state.viewModel.id) {
                    state.completedSessions.remove(state.viewModel.id)
                } else {
                    state.completedSessions.insert(state.viewModel.id)
                }
                
                return .none
            }
        }
    }
}
