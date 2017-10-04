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
    
    lazy var imageView = UIImageView()
    lazy var titleLabel = UILabel()
    
    var post: Post!

    override func viewDidLoad() {
        super.viewDidLoad()

        setViewProperties()
        
    }
    
    func setViewProperties() {
        
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(showTitleLabel))
//        view.isUserInteractionEnabled = true
//        view.addGestureRecognizer(gesture)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        if let imageURL = URL(string: post.imageURLString) {
            imageView.sd_setImage(with: imageURL, completed: nil)
        }
        
        titleLabel.text = post.title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.avenir(24)
        titleLabel.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.7)
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.alpha = 0
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(imageView)
        }
    }
    
    @objc func showTitleLabel() {
        UIView.animate(withDuration: 0.2, animations: {
            self.titleLabel.alpha = 1
        }) { (finished) in
            _ = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.hideTitleLabel), userInfo: nil, repeats: false)
        }
    }
    
    @objc func hideTitleLabel() {
        UIView.animate(withDuration: 0.2) {
            self.titleLabel.alpha = 0
        }
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//        if let touch = touches.first {
//            showTitleLabel()
//        }
//
//    }
    
}
