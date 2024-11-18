//
//  TrackInfo.swift
//  LetSwift2024Light
//
//  Created by Jaewook Hwang on 11/16/24.
//

import Foundation

struct TrackInfo: Decodable {
    let sessionInfoList: [SessionInfo]
    
    enum CodingKeys: String, CodingKey {
        case sessionInfoList = "session_info_list"
    }
}
