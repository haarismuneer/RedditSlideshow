//
//  BrowseViewController.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 9/28/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DataStore.sharedInstance.getPosts(subreddit: "earthporn", timeframe: .all) { (success) in
            
            //            let pageVC = SlideshowPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
            
            DispatchQueue.main.async {
                let vc = SlideViewController()
                vc.imageURLString = DataStore.sharedInstance.postsArray.first?.imageURLString
                self.present(vc, animated: true, completion: nil)
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
