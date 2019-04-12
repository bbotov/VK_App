//
//  VKLoginViewController.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 26.12.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import Foundation
import WebKit
import Alamofire
import Firebase
import FirebaseAuth
import FirebaseDatabase

class VKLoginViewController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView! {
        didSet{
            webview.navigationDelegate = self
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6798280"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.85")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webview.load(request)
        
    }
}


extension VKLoginViewController: WKNavigationDelegate {
    
    func deleteCookies() {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            dataStore.removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), for: records) {
                print("Deleted: " + records.description)
                
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        print(params)
        
        guard let token = params["access_token"], let userId = Int(params["user_id"]!) else {
            decisionHandler(.cancel)
            return
        }
        
        print(token, userId)
        Session.instance.token = token
        Session.instance.userld = userId
        
//        loadUserGroupAlamofire()
//        loadUserGroupSearchAlamofire()
//        loadUserFriendAlamofire()
//        loadUserPhotosAlamofire()
        
        decisionHandler(.cancel)
        
        if userId == 0 {
            
        } else {
            performSegue(withIdentifier: "add229", sender: nil)
            
            Auth.auth().signInAnonymously() { (authResult, error) in
            }
            
            let userIdVK = Session.instance.userld
            let ref = Database.database().reference(withPath: "user")
            let idVK = FirebaseVKId(id: userIdVK, zipcode: Int.random(in: 100000...9999999))
            let iid = String(userIdVK)
            let idRef = ref.child(iid.lowercased())
            idRef.setValue(idVK.toAnyObject())
        }
    
    }
    
    func loadUserGroupAlamofire() {
        
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": Session.instance.token,
            "extended": "1",
            "v": "5.58"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON {
            (response) in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                print(value)
            }
        }
    }
    
    func loadUserGroupSearchAlamofire() {
        
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let params: Parameters = [
            "access_token": Session.instance.token,
            "q": "Games",
            "v": "5.92"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON {
            (response) in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                print(value)
            }
        }
    }
    
    func loadUserFriendAlamofire() {
        
        let baseUrl = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": Session.instance.token,
            "order": "name",
            "fields": "nickname, domain, city",
            "v": "5.8"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON {
            (response) in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                print(value)
            }
        }
    }
    
    func loadUserPhotosAlamofire() {
        
        let baseUrl = "https://api.vk.com"
        let path = "/method/photos.get"
        
        let params: Parameters = [
            "access_token": Session.instance.token,
            "album_id": "wall",
            "v": "5.92"
        ]
        
        Alamofire.request(baseUrl + path, method: .get, parameters: params).responseJSON {
            (response) in
            switch response.result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                print(value)
            }
        }
    }
}

