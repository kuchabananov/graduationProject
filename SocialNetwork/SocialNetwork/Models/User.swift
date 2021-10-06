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
        case sex
        case birthDate = "bdate"
        case city
        case country
        case homeTown = "home_town"
        case online
        //case education
        //case schools
        case status
        case screenName = "screen_name"
        case military
        case counters
        case personal
        case university
        case universityName = "university_name"
        case faculty
        case facultyName = "faculty_name"
        case graduation
    }
    
    var id: Int?
    var firstName: String
    var lastName: String
    var photo: String?
    var sex: Int?
    var birthDate: String?
    var city: City?
    var country: Country?
    var homeTown: String?
    var online: Int?
    //var education: Education?
    //var schools: [Schools]?
    var status: String?
    var screenName: String?
    var military: [Military]?
    var counters: Counters?
    var personal: Personal?
    var university: Int?
    var universityName: String?
    var faculty: Int?
    var facultyName: String?
    var graduation: Int?
    
}

struct City: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    var id: Int?
    var title: String?
    
}

struct Country: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
    }
    
    var id: Int?
    var title: String?
    
}

//struct Education: Decodable {
//
//    enum CodingKeys: String, CodingKey {
//        case university
//        case universityName = "university_name"
//        case faculty
//        case facultyName = "faculty_name"
//        case graduation
//    }
//
//    var university: Int?
//    var universityName: String?
//    var faculty: Int?
//    var facultyName: String?
//    var graduation: Int?
//
//}

struct Military: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case unit
        case unitId = "unit_id"
        case countryId = "country_id"
        case from
        case until
    }
    
    var unit: String?
    var unitId: Int?
    var countryId: Int?
    var from: Int?
    var until: Int?
    
}

struct Counters: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case videos
        case audios
        case friends
        case photos
        case followers
        case groups
    }
    
    var videos: Int?
    var audios: Int?
    var friends: Int?
    var photos: Int?
    var followers: Int?
    var groups: Int?
    
}

struct Personal: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case political
        case religion
        case inspiredBy = "inspired_by"
        case peopleMain = "people_main"
        case lifeMain = "life_main"
        case smoking
        case alcohol
    }

    var political: Int?
    var religion: String?
    var inspiredBy: String?
    var peopleMain: Int?
    var lifeMain: Int?
    var smoking: Int?
    var alcohol: Int?
    
}
