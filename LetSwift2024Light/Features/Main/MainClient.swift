//
//  MainClient.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/19/24.
//

import Foundation
import ComposableArchitecture

// MARK: - MainClient

@DependencyClient
struct MainClient {
    var fetchTrackInfo: (String) async throws -> TrackInfo?
}

// MARK: DependencyKey

extension MainClient: DependencyKey {
    public static var liveValue = Self(
        fetchTrackInfo: unimplemented("MainClient.fetchTrackInfo")
    )
}

extension DependencyValues {
    var mainClient: MainClient {
        get { self[MainClient.self] }
        set { self[MainClient.self] = newValue }
    }
}

// MARK: - TestDependencyKey

extension MainClient: TestDependencyKey {
    public static var testValue = Self(
        fetchTrackInfo: { _ in
                .init(sessionInfoList: [
                    .init(
                        id: 1,
                        title: "앱의 경계를 넘다: Interactive Widget",
                        speakerInfo: .init(
                            name: "유재호",
                            description: "사용자들에게 더 큰 가치를 제공하는 앱을 만들기 위해 노력하는 iOS 개발자입니다.",
                            nickname: nil
                        ),
                        time: "11:00 ~ 11:40"
                    )
                ]
            )
        }
    )
}
