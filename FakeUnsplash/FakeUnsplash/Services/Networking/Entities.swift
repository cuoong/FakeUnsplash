//
//  Entity.swift
//  FakeUnsplash
//
//  Created by Trần Tý on 9/12/19.
//  Copyright © 2019 cuong. All rights reserved.
//

import Foundation
import ObjectMapper

struct UnsplashEntities {
    struct PhotoEntity: ImmutableMappable {
        init(map: Map) throws {
            id = try map.value("id")
            createdAt = try? map.value("created_at")
            updatedAt = try? map.value("updated_at")
            width = try? map.value("width")
            height = try? map.value("height")
            color = try? map.value("color")
            downloads = try? map.value("downloads")
            likes = try? map.value("likes")
            likedByUser = try? map.value("liked_by_user")
            description = try? map.value("description")
            links = try? map.value("links")
            urls = try map.value("urls")
        }
        
        var id: String
        var createdAt: Date?
        var updatedAt: Date?
        var width: Float?
        var height: Float?
        var color: String?
        var downloads: Int?
        var likes: Int?
        var likedByUser: Bool?
        var description: String?
        var links: PhotoLinks?
        var urls: PhotoUrls
    }
    struct PhotoLinks: Mappable {
        
        var download: String
        var donwloadLocation: String
        var html: String
        var this: String
        
        init?(map: Map) {
            download = ""
            donwloadLocation = ""
            html = ""
            this = ""
        }
        
        mutating func mapping(map: Map) {
            download <- map["download"]
            donwloadLocation <- map["download_location"]
            html <- map["html"]
            this <- map["self"]
        }
    }
    
    struct PhotoUrls: ImmutableMappable {
        var raw: String
        var full: String
        var regular: String
        var small: String
        var thumb: String
        
        init(map: Map) throws {
            raw = try map.value("raw")
            full = try map.value("raw")
            regular = try map.value("regular")
            small = try map.value("small")
            thumb = try map.value("thumb")
        }
    }
    
    struct TokenResponse: Mappable {
    
        var accessToken : String
        var tokenType: String
        var scope: String
        var createAt: Date
        init?(map: Map) {
            accessToken = ""
            tokenType = ""
            scope = ""
            createAt = Date()
        }
        
        mutating func mapping(map: Map) {
            accessToken <- map["access_token"]
            tokenType <- map["token_type"]
            scope <- map["scope"]
            createAt <- (map["created_at"], DateTransform())
        }
        
    }
}
