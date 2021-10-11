//
//  Photos.swift
//  SocialNetwork
//
//  Created by Евгений on 10.10.21.
//

import Foundation

struct Photo: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumId = "album_id"
        case ownerId = "owner_id"
        case sizes
    }
    
    var id: Int?
    var albumId: Int?
    var ownerId: Int?
    var sizes: [Sizes]
    
}


struct Sizes: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
        case type
    }
    
    var url: String?
    var width: Int?
    var height: Int?
    var type: String?
    
}
