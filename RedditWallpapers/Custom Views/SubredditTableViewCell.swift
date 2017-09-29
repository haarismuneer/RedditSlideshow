//
//  SubredditTableViewCell.swift
//  RedditWallpapers
//
//  Created by Haaris Muneer on 9/29/17.
//  Copyright © 2017 Haaris Muneer. All rights reserved.
//

import UIKit
import SnapKit

class SubredditTableViewCell: UITableViewCell {
    
    lazy var titleLabel = UILabel()
    var subredditName: String! {
        didSet {
            titleLabel.text = "/r/" + subredditName
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.avenir(36)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
