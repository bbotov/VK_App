//
//  NewsCell.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 20.11.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//
import UIKit

//class NewsCell: UITableViewCell {


class NewsViewCell: UITableViewCell {
    
    @IBOutlet weak var postIcon: UIImageView! {
        didSet {
            self.postIcon?.layer.borderColor = UIColor.white.cgColor
            self.postIcon?.layer.borderWidth = 1.5
        }
    }
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var postPhoto: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var commentsImage: UIImageView!
    @IBOutlet weak var repostsImage: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var repostsCount: UILabel!
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        self.postIcon?.clipsToBounds = true
        self.postIcon?.layer.cornerRadius = self.postIcon.frame.width / 2
    }
//    @IBOutlet weak var scrollView: UIScrollView!
    
    //    @IBOutlet weak var likeButton: UIButton!
    //    @IBOutlet weak var newsLabel: UILabel!
    //    @IBOutlet weak var newsPhoto: UIImageView!
    //
    //    var index: Int = 0
    //    var onLikePressed: ((Int) -> ())?
    //
    //
    //    @IBAction func likePressed(_ sender: Any) {
    //        onLikePressed?(index)
    //    }
    //
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        // Initialization code
    //    }
    //
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    
}
