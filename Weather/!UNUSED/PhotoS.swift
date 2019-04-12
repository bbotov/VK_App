//
//  PhotoS.swift
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
//class PhotosVKService {
//    private let baseUrl = "https://api.vk.com"
//    private let path = "/method/photos.get"
//    
//    public func loadListPhotosVK(completionHandler: (([PhotosVK]?, Error? ) -> Void)? = nil) {
//        
//        let params: Parameters = [
//            "access_token": Session.instance.token,
//            "album_id": "profile",
//            "photos_sizes": "1",
//            "v": "5.60"
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
//                let photos = json["response"]["items"].arrayValue.map { PhotosVK(json: $0) }
//                completionHandler?(photos, nil)
//                
//                print(photos)
//            }
//        }
//    }
//    
//    static func urlForFriendsIcon(_ icon: String) -> URL? {
//        return URL(string: "https://api.vk.com/img/w/\(icon).png")
//    }
//}
