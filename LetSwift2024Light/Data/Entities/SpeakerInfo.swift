//
//  SpeakerInfo.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import Foundation

struct SpeakerInfo: Decodable, Equatable, Hashable {
    let name: String?
    let description: String?
    let nickname: String?
}
