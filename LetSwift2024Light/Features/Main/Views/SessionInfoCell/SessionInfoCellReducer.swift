//
//  SessionInfoCellReducer.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import ComposableArchitecture

// MARK: - SessionInfoCellReducer

@Reducer
struct SessionInfoCellReducer {
    // MARK: - State

    @ObservableState
    struct State: Equatable, Identifiable, Hashable {
        let id: Int
        let info: SessionInfo
        var isComplete: Bool = false
    }

    // MARK: - Action

    enum Action {
        case didTapCompleteButton
    }

    // MARK: - Reducer

    var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
