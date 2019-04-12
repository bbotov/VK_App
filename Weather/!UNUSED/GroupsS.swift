//
//  GroupsS.swift
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
//class GroupsService {
//    private let baseUrl = "https://api.vk.com"
//    private let path = "/method/groups.get"
//    
//    public func loadListGroups(completionHandler: (([GroupsVK]?, Error? ) -> Void)? = nil) {
//        
//        let params: Parameters = [
//            "access_token": Session.instance.token,
//            "extended": "1",
//            "v": "5.58"
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
//                let groups = json["response"]["items"].arrayValue.map { GroupsVK(json: $0) }
//                completionHandler?(groups, nil)
//                
//                print(groups)
//            }
//        }
//    }
//    
//    static func urlForFriendsIcon(_ icon: String) -> URL? {
//        return URL(string: "https://api.vk.com/img/w/\(icon).png")
//    }
//}
