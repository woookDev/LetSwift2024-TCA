//
//  MainReducerTests.swift
//  LetSwift2024LightTests
//
//  Created by Jaewook Hwang on 11/20/24.
//

import XCTest
import ComposableArchitecture
@testable import LetSwift2024Light

final class MainReducerTests: XCTestCase {
    func test_MainReducer_didTapTrackButton_trackB() async throws {
        let testStore = await TestStore(initialState: MainReducer.State()) {
            MainReducer()
        }
        
        await testStore.send(.sessionHeader(.didTapTrackButton(.trackB))) {
            $0.selectedTrackType = .trackB
            $0.sessionHeader.selectedType = .trackB
        }
        
        await testStore.receive(\.receiveData, timeout: 2) {
            $0.cellItems = [
                .init(
                    id: 1,
                    info: .init(
                        id: 1,
                        title: "앱의 경계를 넘다: Interactive Widget",
                        speakerInfo: .init(
                            name: "유재호",
                            description: "사용자들에게 더 큰 가치를 제공하는 앱을 만들기 위해 노력하는 iOS 개발자입니다.",
                            nickname: nil
                        ),
                        time: "11:00 ~ 11:40"
                    )
                )
            ]
        }
    }
    
    func test_MainReducer_didTapCompleteButton() async throws {
        let testStore = await TestStore(initialState: MainReducer.State()) {
            MainReducer()
        }
        
        
        await testStore.send(.sessionHeader(.didTapTrackButton(.trackB))) {
            $0.selectedTrackType = .trackB
            $0.sessionHeader.selectedType = .trackB
        }
        
        await testStore.receive(\.receiveData, timeout: 2) {
            $0.cellItems = [
                .init(
                    id: 1,
                    info: .init(
                        id: 1,
                        title: "앱의 경계를 넘다: Interactive Widget",
                        speakerInfo: .init(
                            name: "유재호",
                            description: "사용자들에게 더 큰 가치를 제공하는 앱을 만들기 위해 노력하는 iOS 개발자입니다.",
                            nickname: nil
                        ),
                        time: "11:00 ~ 11:40"
                    )
                )
            ]
        }
        
        await testStore.send(.cellAction(.element(id: 1, action: .didTapCompleteButton))) {
            $0.$completedSessions.wrappedValue = Set<Int>([1])
        }
    }
    
    func test_MainReducer_didSelectSessionCell() async throws {
        let testStore = await TestStore(initialState: MainReducer.State()) {
            MainReducer()
        }
        
        
        await testStore.send(.sessionHeader(.didTapTrackButton(.trackB))) {
            $0.selectedTrackType = .trackB
            $0.sessionHeader.selectedType = .trackB
        }
        
        await testStore.receive(\.receiveData, timeout: 2) {
            $0.cellItems = [
                .init(
                    id: 1,
                    info: .init(
                        id: 1,
                        title: "앱의 경계를 넘다: Interactive Widget",
                        speakerInfo: .init(
                            name: "유재호",
                            description: "사용자들에게 더 큰 가치를 제공하는 앱을 만들기 위해 노력하는 iOS 개발자입니다.",
                            nickname: nil
                        ),
                        time: "11:00 ~ 11:40"
                    )
                )
            ]
        }
        
        await testStore.send(.didSelectSessionCell(
            .init(
                id: 1,
                info: .init(
                    id: 1,
                    title: "앱의 경계를 넘다: Interactive Widget",
                    speakerInfo:
                            .init(
                                name: "유재호",
                                description: "사용자들에게 더 큰 가치를 제공하는 앱을 만들기 위해 노력하는 iOS 개발자입니다.",
                                nickname: nil
                            ),
                    time: "11:00 ~ 11:40"
                )
            )
        )
        ) {
            $0.sessionDetail = .init(
                sessionDetailInfoViewModel: .init(
                    id: 1,
                    title: "앱의 경계를 넘다: Interactive Widget",
                    time: "11:00 ~ 11:40"
                ),
                speakerInfoViewModel: .init(
                    id: 1,
                    speakerName: "유재호",
                    speakerDescription: "사용자들에게 더 큰 가치를 제공하는 앱을 만들기 위해 노력하는 iOS 개발자입니다."
                )
            )
        }
    }
}
