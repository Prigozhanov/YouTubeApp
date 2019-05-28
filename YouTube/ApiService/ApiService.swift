//
//  ApiService.swift
//  YouTube
//
//  Created by Uladzimir Pryhazhanau on 5/24/19.
//  Copyright © 2019 epam. All rights reserved.
//

import Foundation

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, err) in
            if err != nil {
                print(err!)
                return
            }
            
            do {
                
                let videos: [Video] = try JSONDecoder().decode([Video].self, from: data!)
                completion(videos)
            } catch let jsonError {
                print(jsonError)
            }
            }.resume()
    }
    
}
