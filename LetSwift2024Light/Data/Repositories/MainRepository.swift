//
//  MainRepository.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import Foundation

protocol MainRepository {
    func fetchSessionsInfo(typeString: String) async throws -> TrackInfo?
}

struct MainRepositoryImpl: MainRepository {
    let jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }
    
    func fetchSessionsInfo(typeString: String) async throws -> TrackInfo? {
        let task = Task(priority: .background) { () -> TrackInfo? in
            guard let path = Bundle.main.path(
                forResource: "track_\(typeString)_session_info.json", ofType: nil
            ) else { return nil }
            
            let data = try Data(
                contentsOf: URL(fileURLWithPath: path),
                options: .alwaysMapped
            )
            
            return try jsonDecoder.decode(
                TrackInfo.self,
                from: data
            )
        }
        
        return try await task.value
    }
}
