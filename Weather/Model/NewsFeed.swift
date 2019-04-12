//
//  NewsFeed.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 07.03.2019.
//  Copyright © 2019 Boris Botov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class NewsFeedVK: Object {
    
    @objc dynamic var uuid = UUID().uuidString
    
    @objc dynamic var type = ""
    @objc dynamic var date = 0
    @objc dynamic var source_Id = 0
    @objc dynamic var post_Id = 0
    @objc dynamic var text = ""
    
    @objc dynamic var commentsCount = 0
    
    @objc dynamic var likesCount = 0
    
    @objc dynamic var repostsCount = 0
    
    @objc dynamic var photo_Id = 0
    @objc dynamic var photo_Icon = ""
    @objc dynamic var access_key = 0
    
    convenience init(json: JSON) {
        self.init()
        
        self.type = json["type"].stringValue
        self.date = json["date"].intValue
        self.source_Id = json["source_id"].intValue
        self.post_Id = json["post_id"].intValue
        self.text = json["text"].stringValue
        self.commentsCount = json["comments"]["count"].intValue
        self.likesCount = json["likes"]["count"].intValue
        self.repostsCount = json["reposts"]["count"].intValue
        self.photo_Id = json["attachments"][0]["photo"]["id"].intValue
        self.access_key = json["attachments"][0]["photo"]["access_key"].intValue
        self.photo_Icon = json["attachments"][0]["photo"]["sizes"][3]["url"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "source_Id"
    }
    
    var url: String {
        return photo_Icon
    }
}
