//
//  DatabaseService.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 01.02.2019.
//  Copyright © 2019 Boris Botov. All rights reserved.
//

import RealmSwift

class DatabaseService {
    
    @discardableResult
    static func save<T: Object>(_ items: [T], config: Realm.Configuration =
        Realm.Configuration.defaultConfiguration, update:Bool = true) throws -> Realm {
        print(config.fileURL ?? "")
        let realm = try Realm(configuration: config)
        
        try realm.write {
            realm.add(items, update: true)
        }
        
        return realm
    }
    
    static func get<T: Object>(_ type: T.Type, config: Realm.Configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)) -> Results<T>? {
        let realm = try? Realm(configuration: config)
        
        return realm?.objects(type)
    }
    
    @discardableResult
    static func delete<T: Object>(_ items: [T], config: Realm.Configuration = Realm.Configuration.defaultConfiguration) throws -> Realm {
        let realm = try Realm(configuration: config)
        
        try realm.write {
            realm.delete(items)
        }
        return realm
    }
}
