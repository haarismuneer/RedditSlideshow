//
//  AppDelegate.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 9/28/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//

//TODO: preview images
//TODO: filter out dumb images
//TODO: find best subreddits
//TODO: title label

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        DataStore.sharedInstance.getFeaturedSubreddits { (success) in
            if success {
                DispatchQueue.main.async {
                    self.window?.rootViewController = BrowseViewController()
                    self.window?.makeKeyAndVisible()
                }
                
            }
        }
        
        
        return true
    }


}

