//
//  NewGroupS.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 08.01.2019.
//  Copyright © 2019 Boris Botov. All rights reserved.
//
//
//import Foundation
//import SwiftyJSON
//import Alamofire
//
//class GroupsNewVKService {
//    private let baseUrl = "https://api.vk.com"
//    private let path = "/method/groups.search"
//    
//    public func loadListGroupsNew(searchText: String, completionHandler: (([GroupsNewVK]?, Error? ) -> Void)? = nil) {
//        
//        let params: Parameters = [
//            "access_token": Session.instance.token,
//            "q": searchText,
//            "v": "5.92"
//        ]
//        
//        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON {
//            (response) in
//            switch response.result {
//            case .failure(let error):
//                completionHandler?(nil, error)
//            case .success(let value):
//                let json = JSON(value)
//                
//                let groupsNew = json["response"]["items"].arrayValue.map { GroupsNewVK(json: $0) }
//                completionHandler?(groupsNew, nil)
//                
//                print(groupsNew)
//            }
//        }
//    }
//    
//    static func urlForFriendsIcon(_ icon: String) -> URL? {
//        return URL(string: "https://api.vk.com/img/w/\(icon).png")
//    }
//}
