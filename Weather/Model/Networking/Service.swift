//
//  FriendsS.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 08.01.2019.
//  Copyright © 2019 Boris Botov. All rights reserved.
//

import Foundation
//import UIKit
import SwiftyJSON
import Alamofire

class FriendsS {
    
    public func loadListFriends(completionHandler: (([Friends]?, Error? ) -> Void)? = nil) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": Session.instance.token,
            "order": "hints",
            "fields": "nickname, photo_200",
            "v": "5.8"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON {
            (response) in
            switch response.result {
            case .failure(let error):
                completionHandler?(nil, error)
                print(error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                
                let friends = json["response"]["items"].arrayValue.map { Friends(json: $0) }
                completionHandler?(friends, nil)
            }
        }
    }
    
    static func urlForFriendVK(_ avatar: String) -> URL? {
        return URL(string: avatar)
    }
}

class GroupsNewVKService {
    private let baseUrl = "https://api.vk.com"
    private let path = "/method/groups.search"
    
    public func loadListGroupsNew(searchText: String, completionHandler: (([GroupsNewVK]?, Error? ) -> Void)? = nil) {
        
        let params: Parameters = [
            "access_token": Session.instance.token,
            "q": searchText,
            "v": "5.92"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON {
            (response) in
            switch response.result {
            case .failure(let error):
                completionHandler?(nil, error)
            case .success(let value):
                let json = JSON(value)
                
                let groupsNew = json["response"]["items"].arrayValue.map { GroupsNewVK(json: $0) }
                completionHandler?(groupsNew, nil)
                
                print(groupsNew)
            }
        }
    }
    
    static func urlForFriendsIcon(_ icon: String) -> URL? {
        return URL(string: "https://api.vk.com/img/w/\(icon).png")
    }
}

class GroupsService {
    private let baseUrl = "https://api.vk.com"
    private let path = "/method/groups.get"
    
    public func loadListGroups(completionHandler: (([GroupsVK]?, Error? ) -> Void)? = nil) {
        
        let params: Parameters = [
            "access_token": Session.instance.token,
            "extended": "1",
            "v": "5.58"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON {
            (response) in
            switch response.result {
            case .failure(let error):
                completionHandler?(nil, error)
            case .success(let value):
                let json = JSON(value)
                
                let groups = json["response"]["items"].arrayValue.map { GroupsVK(json: $0) }
                completionHandler?(groups, nil)
                
                print(groups)
            }
        }
    }
    
    static func urlForFriendsIcon(_ icon: String) -> URL? {
        return URL(string: "https://api.vk.com/img/w/\(icon).png")
    }
}

class PhotosVKService {
    
    public func loadListPhotosVK(for user: String, completionHandler: (([PhotosVK]?, Error? ) -> Void)? = nil) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let params: Parameters = [
            "access_token" : Session.instance.token,
            "owner_id" : user,
            "extended" : "1",
            "count" : "200",
            "v" : "5.92"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON {
            (response) in
            switch response.result {
            case .failure(let error):
                completionHandler?(nil, error)
                print(error.localizedDescription)
            case .success(let value):
                let json = JSON(value)
                let photos = json["response"]["items"].arrayValue.map { PhotosVK(json: $0) }
                completionHandler?(photos, nil)
            }
        }
    }
    
    static func urlForUserVKPhoto(_ photo: String) -> URL? {
        return URL(string: photo)
    }
}


