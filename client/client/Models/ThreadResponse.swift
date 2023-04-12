//
//  ThreadResponse.swift
//  client
//
//  Created by matheusvb on 11/04/23.
//

import Foundation

struct RawThread: Codable {
    let data: [ThreadResponse]
}

struct ThreadResponse: Codable, Hashable {
    var data: String
    let id: String
    let type: String
    let userId: String
    let votes: Int
}
