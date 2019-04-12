//
//  FirebaseVKId.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 01.02.2019.
//  Copyright © 2019 Boris Botov. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseVKId {
    
    let id: Int
    let zipcode: Int
    let ref: DatabaseReference?
    
    init(id: Int, zipcode: Int) {
        self.id = id
        self.zipcode = zipcode
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
            let zipcode = value["zipcode"] as? Int,
            let id = value["id"] as? Int else { return nil }
        
        self.id = id
        self.zipcode = zipcode
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "id": id,
            "zipcode": zipcode
        ]
    }
}
