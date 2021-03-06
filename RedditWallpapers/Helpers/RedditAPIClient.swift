//
//  RedditAPIClient.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 9/28/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//

import UIKit
import SwiftyJSON

enum Timeframe: String {
    case all = "all"
    case hour = "hour"
    case day = "day"
    case week = "week"
    case month = "month"
    case year = "year"
}

class RedditAPIClient {
    
    static func getPosts(subreddit: String, timeframe: Timeframe, completion: @escaping(([JSON?], Error?) -> Void)) {
        //https://api.reddit.com/r/earthporn/top?sort=top&t=all
        guard let url = URL(string: Constants.redditAPIBaseURL + "/r/\(subreddit)/top?sort=top&t=\(timeframe.rawValue)&limit=50")
            else { print("invalid URL in getPosts"); return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("no data received in getPosts")
                completion([], error)
                return
            }
            
            let json = JSON(data: data)
            if let posts = json["data"]["children"].array {
                completion(posts, nil)
            }
            
        }.resume()
        
    }
    
    static func getTopPostImageURL(subreddit: String, completion: @escaping((String?, Error?) -> ())) {
        guard let url = URL(string: Constants.redditAPIBaseURL + "/r/\(subreddit)/top?sort=top&limit=1")
            else {
                print("invalid URL in getTopPost")
                completion(nil, nil)
                return
            }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("no data received in getTopPost ")
                completion(nil, error)
                return
            }
            
            let json = JSON(data: data)
            if let urlString = json["data"]["children"][0]["data"]["preview"]["images"][0]["source"]["url"].string {
                completion(urlString, nil)
            } else {
                completion(nil, nil)
            }
            
            }.resume()
    }
    
    
    
    
}
