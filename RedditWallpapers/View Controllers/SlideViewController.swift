//
//  SlideViewController.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 9/28/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class SlideViewController: UIViewController {
    
    var imageView = UIImageView()
    
    var imageURLString: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        setViewProperties()
        
    }
    
    func setViewProperties() {
        view.backgroundColor = .darkGray
        
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        if let imageURL = URL(string: imageURLString) {
            imageView.sd_setImage(with: imageURL, completed: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
