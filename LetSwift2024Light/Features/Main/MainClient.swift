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
