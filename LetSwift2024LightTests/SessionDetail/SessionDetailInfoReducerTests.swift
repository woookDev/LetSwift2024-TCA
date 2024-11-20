//
//  SessionDetailInfoReducerTests.swift
//  LetSwift2024LightTests
//
//  Created by Jaewook Hwang on 11/20/24.
//

import XCTest
import ComposableArchitecture
@testable import LetSwift2024Light

final class SessionDetailInfoReducerTests: XCTestCase {
    func test_MainReducer_didTapCompleteButton() async throws {
        let testStore = await TestStore(initialState: SessionDetailInfoReducer.State(
            viewModel: .init(
                id: 1,
                title: "앱의 경계를 넘다: Interactive Widget",
                time: "11:00 ~ 11:40"
            )
        )
        ) {
            SessionDetailInfoReducer()
        }
        
        await testStore.send(.didTapCompleteButton) {
            $0.$completedSessions.wrappedValue = Set<Int>([1])
        }
    }
}
