//
//  Photo.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 08.01.2019.
//  Copyright © 2019 Boris Botov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class PhotosVK: Object {
//    var description: String {
//        return String("\(user_Id) \(name_Id) \(icon_Name)")
//    }
    @objc dynamic var uuid = UUID().uuidString
    @objc dynamic var id : Int = 0
    @objc dynamic var album_id : Int = 0
    
    @objc dynamic var type : String = ""
    @objc dynamic var url : String = ""
    @objc dynamic var likes : Int = 0
    @objc dynamic var userLike : Int = 0
    
    convenience init(json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.album_id = json["album_id"].intValue
        self.type = json["sizes"][3]["type"].stringValue
        self.url = json["sizes"][3]["url"].stringValue
        self.likes = json["likes"]["count"].intValue
        self.userLike = json["likes"]["user_likes"].intValue
    }
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
//    @objc dynamic var icon_Name = ""
//    @objc dynamic var url = ""
//    @objc dynamic var name_Id = 0
//    @objc dynamic var user_Id = 0
//
//    convenience init(json: JSON) {
//        self.init()
//
//        self.icon_Name = json["photo_75"].stringValue
//        self.url = json["sizes"][3]["url"].stringValue
//        self.name_Id = json["id"].intValue
//        self.user_Id = json["owner_id"].intValue
//    }
}
