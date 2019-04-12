//
//  NewsProfile.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 07.03.2019.
//  Copyright © 2019 Boris Botov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class NewsProfile: Object {
    
    @objc dynamic var uuid = UUID().uuidString
    @objc dynamic var profiles_Id = 0
    @objc dynamic var profiles_FirstName = ""
    @objc dynamic var profiles_LastName = ""
    @objc dynamic var profiles_Icon = ""
    
    
    convenience init(json: JSON) {
        self.init()
        
        self.profiles_Id = json["id"].intValue
        self.profiles_FirstName = json["first_name"].stringValue
        self.profiles_LastName = json["last_name"].stringValue
        self.profiles_Icon = json["photo_50"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "profiles_Id"
    }
}
