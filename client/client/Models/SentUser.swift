//
//  SentUser.swift
//  client
//
//  Created by jpbol on 29/03/2023.
//

import Foundation

struct SentUser: Codable {
    let id: String
    let name: String
    let email: String
    let token: String
    let gamesWon: Int?
    let likes: Int?
}
