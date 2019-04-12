//
//  MyNamesCell.swift
//  Weather
//
//  Created by Boris Botov on 11.11.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import UIKit
import Kingfisher

class MyNamesCell: UITableViewCell {

    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var icon: UIImageView! {
        didSet {
            self.icon?.layer.borderColor = UIColor.white.cgColor
            self.icon?.layer.borderWidth = 1.5
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        self.icon?.clipsToBounds = true
        self.icon?.layer.cornerRadius = self.icon.frame.width / 2
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
