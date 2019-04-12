//
//  NewsFeedVKService.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 07.03.2019.
//  Copyright © 2019 Boris Botov. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import RealmSwift

class NewsFeedVKService {
    
    private let baseUrl = "https://api.vk.com"
    private let path = "/method/newsfeed.get"
    
//    GCD
    
    let myQueue = DispatchQueue(label: "myQueue",
                                qos: DispatchQoS.background,
                                attributes: DispatchQueue.Attributes.concurrent)
    let dispatchGroup = DispatchGroup()
    
    public func loadListNewsFeedVK(completionHandler: (([NewsGroup]?, [NewsProfile]?, [NewsFeedVK]?, Error? ) -> Void)? = nil) {
        
        let params: Parameters = [
            "access_token": Session.instance.token,
            "filters": "post",
            "count": "100",
            "v": "5.92"
        ]
        
        Alamofire.request(self.baseUrl + self.path, method: .get, parameters: params).responseJSON {
            (response) in
            switch response.result {
            case .failure(let error):
                completionHandler?(nil, nil, nil, error)
            case .success(let value):
                let json = JSON(value)
                print(value)
                
                var newsGroup = [NewsGroup]()
                var newsProfile = [NewsProfile]()
                
                self.myQueue.async(group: self.dispatchGroup) {
                    newsGroup = json["response"]["groups"].arrayValue.map { NewsGroup(json: $0) }
                }
                self.myQueue.async(group: self.dispatchGroup) {
                    newsProfile = json["response"]["profiles"].arrayValue.map { NewsProfile(json: $0) }
                }
                
                self.dispatchGroup.notify(queue: DispatchQueue.main) {
                    
                    let newsFeedVK = json["response"]["items"].arrayValue.map { NewsFeedVK(json: $0) }
                    completionHandler?(newsGroup, newsProfile, newsFeedVK, nil)
                    
                    print(newsFeedVK, newsGroup, newsProfile)
                }
            }
        }
    }
}
