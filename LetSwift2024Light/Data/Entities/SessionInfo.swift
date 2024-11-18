//
//  SessionInfo.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import Foundation

struct SessionInfo: Decodable, Equatable, Hashable {
    let id: Int
    let title: String
    let speakerInfo: SpeakerInfo
    let time: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case speakerInfo = "speaker"
        case time
    }
}
