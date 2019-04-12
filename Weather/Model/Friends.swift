//
//  Friends.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 08.01.2019.
//  Copyright © 2019 Boris Botov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Friends: Object {
//    var description: String {
//        return String("\(first_Name) \(last_Name) \(name_Id) \(icon_Name)")
//    }
    
    @objc dynamic var uuid = UUID().uuidString
    @objc dynamic var first_Name = ""
    @objc dynamic var last_Name = ""
    @objc dynamic var avatar = ""
    @objc dynamic var name_Id = 0
    @objc dynamic var headerName = ""
    
    convenience init(json: JSON) {
        self.init()
        
        self.first_Name = json["first_name"].stringValue
        self.last_Name = json["last_name"].stringValue
        self.avatar = json["photo_200"].stringValue
        self.name_Id = json["id"].intValue
    }
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
