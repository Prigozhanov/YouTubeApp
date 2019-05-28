//
//  TrendingCell.swift
//  YouTube
//
//  Created by Uladzimir Pryhazhanau on 5/24/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos: [Video]) in
            self.videos = videos
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}
