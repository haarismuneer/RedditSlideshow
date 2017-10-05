//
//  AppDelegate.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 9/28/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//


//TODO: find best subreddits


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        application.isIdleTimerDisabled = true
        
        return true
    }

    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        DataStore.sharedInstance.getFeaturedSubreddits { (success) in
            if success {
                DispatchQueue.main.async {
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window?.rootViewController = BrowseViewController()
                    self.window?.makeKeyAndVisible()
                }
            }
            else {//not connected to internet
                DispatchQueue.main.async {
                    self.presentAlert(title: "Error", message: "It looks like you're not connected to the internet. Please reconnect and try again.")
                }
            }
        }
    }

}

