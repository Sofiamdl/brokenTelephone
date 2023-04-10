//
//  SentUser.swift
//  client
//
//  Created by jpbol on 29/03/2023.
//

import Foundation

struct SentUser: Codable {
    var id: String
    var name: String
    var email: String
    var token: String
    var gamesWon: Int?
    var likes: Int?
}
