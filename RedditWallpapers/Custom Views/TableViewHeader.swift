//
//  TableViewHeader.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 10/4/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//

import UIKit
import SnapKit

class TableViewHeader: UIView {
    
    var textLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textLabel.text = "Choose a subreddit!"
        self.textLabel.textColor = .white
        self.textLabel.font = UIFont.avenir(40)
        self.addSubview(textLabel)
        
        self.textLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
