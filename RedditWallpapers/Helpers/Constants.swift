//
//  Constants.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 9/28/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//

import UIKit

struct Constants {

    static let redditAPIBaseURL = "https://api.reddit.com"
    static let imgurAPIBaseURL = "https://api.imgur.com/3"
    
}

extension UIFont {
    class func avenir(_ size : CGFloat) -> UIFont {
        return UIFont(name: "Avenir", size: size)!
    }
    
    class func avenirHeavy(_ size : CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Heavy", size: size)!
    }
}
