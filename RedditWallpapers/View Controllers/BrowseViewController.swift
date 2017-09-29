//
//  BrowseViewController.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 9/28/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class BrowseViewController: UIViewController {
    
    var tableView = UITableView()
    var rightSideView = UIView()
    var previewImageView = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewProperties()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        tableView.remembersLastFocusedIndexPath = true
        self.setNeedsFocusUpdate()
        self.updateFocusIfNeeded()
        
    }

    func setViewProperties() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
//        view.sendSubview(toBack: blurEffectView)
        
        tableView.register(SubredditTableViewCell.self, forCellReuseIdentifier: "subredditCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3)
        }
        
        rightSideView.backgroundColor = .clear
        view.addSubview(rightSideView)
        rightSideView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(tableView.snp.right)
        }
        
        previewImageView.contentMode = .scaleAspectFit
        rightSideView.addSubview(previewImageView)
        previewImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalToSuperview().multipliedBy(0.85)
        }
        
        
    }
    
    
    

}

extension BrowseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.subreddits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subredditCell", for: indexPath) as! SubredditTableViewCell
        cell.subredditName = Constants.subreddits[indexPath.row]
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UITableViewHeaderFooterView()
//        view.textLabel?.text = "Choose a subreddit!"
//        view.textLabel?.font = UIFont.avenirHeavy(48)
//        return view
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 150
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subreddit = Constants.subreddits[indexPath.row]
        DataStore.sharedInstance.getPosts(subreddit: subreddit, timeframe: .all) { (success) in
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
    
    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        print("changed focus")
        if let row = context.nextFocusedIndexPath?.row {
            
            let cell = tableView.cellForRow(at: context.nextFocusedIndexPath!) as! SubredditTableViewCell
            cell.titleLabel.textColor = .black
            
            let subreddit = Constants.subreddits[row]
            let imageURL = DataStore.sharedInstance.featuredSubreddits[subreddit]
            self.previewImageView.sd_setImage(with: imageURL, completed: nil)
        }
        
        if let indexPath = context.previouslyFocusedIndexPath {
            let cell = tableView.cellForRow(at: indexPath) as! SubredditTableViewCell
            cell.titleLabel.textColor = .white
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/15
    }
    
    func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
        return IndexPath(row: 0, section: 0)
    }
    
}
