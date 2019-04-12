//
//  FriendsCell.swift
//  Weather
//
//  Created by Boris Botov on 11.11.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import UIKit
import Kingfisher

class FriendsCell: UICollectionViewCell {
    
    @IBOutlet weak var friend: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var icon: UIImageView! {
        didSet {
            self.icon?.layer.borderColor = UIColor.white.cgColor
            self.icon?.layer.borderWidth = 1.5
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.icon?.clipsToBounds = true
        self.icon?.layer.cornerRadius = self.icon.frame.width / 2
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    var index: Int = 0
//    var onLikePressed: ((Int) -> ())?
//
//    @IBAction func likrPressed(_ sender: Any) {
//        onLikePressed?(index)
//    }
    
}
