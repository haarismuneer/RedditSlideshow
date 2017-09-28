//
//  RedditAPIClient.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 9/28/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//

import UIKit

enum Timeframe: String {
    case all = "all"
    case hour = "hour"
    case day = "day"
    case week = "week"
    case month = "month"
    case year = "year"
}

class RedditAPIClient {
    
    static func getPosts(subreddit: String, timeframe: Timeframe, completion: @escaping(() -> Void)) {
        //https://api.reddit.com/r/earthporn/top?sort=top&t=all
        guard let url = URL(string: Constants.redditAPIBaseURL + "/r/\(subreddit)/top?sort=top&t=\(timeframe.rawValue)")
            else { print("invalid URL in getPosts"); return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { print("no data received in getPosts "); return }
            do {
                let posts = try JSONSerialization.jsonObject(with: data, options: [])
                print(posts)
                
            }
            catch let decodeError {
                print("couldn't decode the JSON", decodeError)
            }
            }.resume()
        
    }
    
    
    
    
}
