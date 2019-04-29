//
//  Video.swift
//  YouTube
//
//  Created by Uladzimir Pryhazhanau on 4/29/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImage: UIImage?
    var title: String?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    var name: String?
    var profileImage: UIImage?
}

