//
//  Friends.swift
//  SocialNetwork
//
//  Created by Евгений on 7.10.21.
//

import Foundation

struct Friend: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_max"
        case city
    }
    
    var id: Int?
    var firstName: String
    var lastName: String
    var photo: String?
    var city: City?
    
}

