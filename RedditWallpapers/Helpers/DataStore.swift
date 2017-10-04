//
//  DataStore.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 9/28/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//

import UIKit
import SwiftyJSON

class DataStore {

    static let sharedInstance = DataStore()
    
    var postsArray: [Post] = []
    
    var featuredSubreddits: [String : URL] = [:]
    
    
    
    func getPosts(subreddit: String, timeframe: Timeframe, completion: @escaping((Bool) -> Void)) {
        RedditAPIClient.getPosts(subreddit: subreddit, timeframe: timeframe) { (posts) in
            self.postsArray.removeAll()
            for postJSON in posts {
                if let image = postJSON?["data"]["preview"]["images"][0]["source"], let title = postJSON?["data"]["title"].string {
                    
                    if image["width"].intValue * image["height"].intValue > Constants.minImageSize {
                        let post = Post(imageURLString: image["url"].stringValue, title: title)
                        self.postsArray.append(post)
                    }
                    
                }
                
            }
            completion(true)
        }
    }
    
    func getFeaturedSubreddits(completion: @escaping((Bool) -> Void)){
        let subreddits = Constants.subreddits
        
        let group = DispatchGroup()
        group.enter()
        
        for sub in subreddits {
            group.enter()
            RedditAPIClient.getTopPostImageURL(subreddit: sub, completion: { (imageURLString) in
                if let urlString = imageURLString, let imageURL = URL(string: urlString) {
                    self.featuredSubreddits[sub] = imageURL
                }
                group.leave()
            })
        }
        group.leave()
        
        group.notify(queue: .main, execute: {
            completion(true)
        })
        
    }
    
}
