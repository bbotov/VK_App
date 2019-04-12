//
//  AllNamesCell.swift
//  Weather
//
//  Created by Boris Botov on 11.11.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import UIKit
import Kingfisher

class AllNamesCell: UITableViewCell {

    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsPhoto: UIImageView! {
        didSet {
            self.newsPhoto?.layer.borderColor = UIColor.white.cgColor
            self.newsPhoto?.layer.borderWidth = 1.5
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()

        self.newsPhoto?.clipsToBounds = true
        self.newsPhoto?.layer.cornerRadius = self.newsPhoto.frame.width / 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    public func configure(with friends: Friends) {
//
//        self.newsLabel.text = String(format: "%.0f", friends.first_Name, friends.last_Name)
//        self.newsPhoto.kf.setImage(with: FriendsS.urlForFriendsIcon(friends.icon_Name))
//    }
}
