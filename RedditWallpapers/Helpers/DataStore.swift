//
//  DataStore.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 9/28/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//

import UIKit
import SwiftyJSON
import GameplayKit

class DataStore {

    static let sharedInstance = DataStore()
    
    var postsArray: [Post] = []
    
    var featuredSubreddits: [String : URL] = [:]
    
    
    
    func getPosts(subreddit: String, timeframe: Timeframe, completion: @escaping((Bool) -> Void)) {
        RedditAPIClient.getPosts(subreddit: subreddit, timeframe: timeframe) { (posts, error) in
            self.postsArray.removeAll()
            if let error = error, (error as NSError).code == -1009 || (error as NSError).code == 1001 {
                completion(false)
                return
            }
            for postJSON in posts {
                if let image = postJSON?["data"]["preview"]["images"][0]["source"],
                    let title = postJSON?["data"]["title"].string {
                    
                    if image["width"].intValue * image["height"].intValue > Constants.minImageSize && image["url"].stringValue.range(of: ".gif") == nil {
                        let post = Post(imageURLString: image["url"].stringValue, title: title)
                        self.postsArray.append(post)
                    }
                }
            }
            self.postsArray = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: self.postsArray) as! [Post]
            completion(true)
        }
    }
    
    func getFeaturedSubreddits(completion: @escaping((Bool) -> Void)){
        let subreddits = Constants.subreddits
        
        let group = DispatchGroup()
        
        for sub in subreddits {
            group.enter()
            
            RedditAPIClient.getTopPostImageURL(subreddit: sub, completion: { (imageURLString, error) in
                print((error as NSError?)?.code)
                if let error = error, (error as NSError).code == -1009 {
                    completion(false)
                    return
                }
                
                if let urlString = imageURLString, let imageURL = URL(string: urlString) {
                    self.featuredSubreddits[sub] = imageURL
                }
                print("done with \(sub)")
                group.leave()
            })
            
        }
        
        group.notify(queue: .main, execute: {
            print("done with all tasks")
            completion(true)
        })
        
        
        
    }
    
}
