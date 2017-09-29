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
    
    func getPosts(subreddit: String, timeframe: Timeframe, completion: @escaping((Bool) -> Void)) {
        RedditAPIClient.getPosts(subreddit: subreddit, timeframe: timeframe) { (posts) in
            self.postsArray.removeAll()
            for postJSON in posts {
                if let imageURL = postJSON?["data"]["preview"]["images"][0]["source"]["url"].string, let title = postJSON?["data"]["title"].string {
                    let post = Post(imageURLString: imageURL, title: title)
                    self.postsArray.append(post)
                    
                }
                
            }
            completion(true)
        }
    }
    
}
