//
//  SessionDetailReducer.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import ComposableArchitecture

// MARK: - SessionDetailReducer

@Reducer
struct SessionDetailReducer {
    // MARK: - State

    @ObservableState
    struct State: Equatable {
        var sessionDetailInfoViewModel: SessionDetailInfoViewModel
        var speakerInfoViewModel: SpeakerInfoViewModel
    }

    // MARK: - Action

    enum Action { }

    // MARK: - Reducer

    var body: some Reducer<State, Action> {
        EmptyReducer()
    }
}
