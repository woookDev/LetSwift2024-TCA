//
//  SessionHeaderReducer.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import ComposableArchitecture

// MARK: - SessionHeaderReducer

@Reducer
struct SessionHeaderReducer {
    // MARK: - State

    @ObservableState
    struct State: Equatable {
        var selectedType: TrackType?
    }

    // MARK: - Action

    enum Action {
        case didTapTrackButton(TrackType)
    }

    // MARK: - Reducer

    var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
