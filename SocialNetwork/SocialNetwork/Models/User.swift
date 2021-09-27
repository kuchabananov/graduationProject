//
//  Model.swift
//  SocialNetwork
//
//  Created by Евгений on 9.09.21.
//

import Foundation

struct User: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_max"
    }
    
    var id: Int?
    var firstName: String?
    var lastName: String?
    var photo: String?
    
}

