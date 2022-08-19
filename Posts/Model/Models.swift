//
//  Models.swift
//  Posts
//
//  Created by Emilly Maia on 10/08/22.
//

import Foundation
import SwiftUI

struct DataModel: Decodable {
    let error: Bool
    let message: String
    let data: [PostModel]
}

struct PostModel: Decodable {
    let id: String
    let content: String
    let media: String?
    let user_id: String
    let like_count: Int
}

struct userModel: Decodable {
    let name: String
    let id: String
    let email: String
    let password: String
}

struct User: Codable {
    var id: UUID
    var name: String
    var email: String
}


