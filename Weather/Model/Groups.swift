//
//  Groups.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 08.01.2019.
//  Copyright © 2019 Boris Botov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class GroupsVK: Object {
//    var description: String {
//        return String("\(user_Id) \(name_Group) \(icon_Group)")
//    }
    
    @objc dynamic var uuid = UUID().uuidString
    @objc dynamic var user_Id = 0
    @objc dynamic var name_Group = ""
    @objc dynamic var icon_Group = ""
    
    convenience init(json: JSON) {
        self.init()
        self.user_Id = json["id"].intValue
        self.name_Group = json["name"].stringValue
        self.icon_Group = json["photo_200"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
