//
//  Video.swift
//  YouTube
//
//  Created by Uladzimir Pryhazhanau on 4/29/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

struct Video: Codable {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: Int64?
    var duration: Int64?
    var channel: Channel?
    
    enum CodingKeys: String, CodingKey {
        case thumbnailImageName = "thumbnail_image_name"
        case title
        case numberOfViews = "number_of_views"
        case duration
        case channel
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(thumbnailImageName, forKey: .thumbnailImageName)
        try container.encode(title, forKey: .title)
        try container.encode(numberOfViews, forKey: .numberOfViews)
        try container.encode(duration, forKey: .duration)
        try container.encode(channel, forKey: .channel)
    }
    
}

struct Channel: Codable {
    var name: String?
    var profileImageName: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profileImageName = "profile_image_name"
    }
    
}

