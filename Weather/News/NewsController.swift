//
//  NewsController.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 20.11.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class NewsTableView: UITableViewController {
    
    var newsFeed = [NewsFeedVK]()
    var newsGroup: Results<NewsGroup>? = DatabaseService.get(NewsGroup.self)
    var newsProfile: Results<NewsProfile>? = DatabaseService.get(NewsProfile.self)
    let newsFeedService = NewsFeedVKService()
    var notificationToken: NotificationToken?
    var photoService: PhotoService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoService = PhotoService(container: self.tableView)
        
        self.newsFeedService.loadListNewsFeedVK() { [weak self] newsGroup, newsProfile, newsFeed, error in
            guard let self = self, error == nil,
                let newsGroup = newsGroup, let newsProfile = newsProfile, let newsFeed = newsFeed else { print(error?.localizedDescription as Any); return }
            
            let realm = try? Realm()
            try? realm?.write {
                if self.newsGroup != nil {
                    realm?.delete(self.newsGroup!)
                }
            }
            try? realm?.write {
                if self.newsProfile != nil {
                    realm?.delete(self.newsProfile!)
                }
            }
            
            try? DatabaseService.save(newsGroup, update: true)
            try? DatabaseService.save(newsProfile, update: true)
            self.newsFeed = newsFeed
            //            self.tableView.reloadData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let dt = DateFormatter()
        dt.dateFormat = "EEEE, HH:mm"
        return dt
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath) as! NewsViewCell
        let newsF = newsFeed[indexPath.row]
        let dateNews = Date(timeIntervalSince1970: TimeInterval(newsF.date))
        
        guard let realm = try? Realm() else { return UITableViewCell() }
        
        if newsF.source_Id > 0,
            let newsPr = realm.object(ofType: NewsProfile.self, forPrimaryKey: newsF.source_Id) {
            cell.postName.text = "\(newsPr.profiles_FirstName) \(newsPr.profiles_LastName)"
            cell.postIcon.kf.setImage(with: URL(string: newsPr.profiles_Icon))
        } else if newsF.source_Id < 0,
            let newsG = realm.object(ofType: NewsGroup.self, forPrimaryKey: -newsF.source_Id) {
            cell.postName.text = newsG.group_Name
            cell.postIcon.kf.setImage(with: URL(string: newsG.group_Icon))
        }
        
        cell.postDate.text = dateFormatter.string(from: dateNews)
        cell.postText.text = newsF.text
        cell.postPhoto.image = photoService?.photo(atIndexpath: indexPath, byUrl: newsF.url)
        cell.likeCount.text = String(newsF.likesCount)
        cell.commentsCount.text = String(newsF.commentsCount)
        cell.repostsCount.text = String(newsF.repostsCount)
        
        return cell
    }
}
