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
            var slideVCArray: [SlideViewController] = []
            DispatchQueue.main.async {
                let pageVC = SlideshowPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
                
                for post in DataStore.sharedInstance.postsArray {
                    let vc = SlideViewController()
                    vc.imageURLString = post.imageURLString
                    slideVCArray.append(vc)
                }
                pageVC.orderedViewControllers = slideVCArray
                self.present(pageVC, animated: true, completion: nil)
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
