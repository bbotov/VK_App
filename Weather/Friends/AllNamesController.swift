//
//  AllNamesController.swift
//  Weather
//
//  Created by Boris Botov on 11.11.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import Firebase
import FirebaseAuth

class AllNamesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func exitB(_ sender: Any) {
        VKLoginViewController().deleteCookies()
        let viewController:
            UIViewController = UIStoryboard(
                name: "Main", bundle: nil
                ).instantiateViewController(withIdentifier: "start229") as UIViewController
        self.present(viewController, animated: true, completion: nil)
        
        try? Auth.auth().signOut()
    }
    
    var filteredFriends = [Friends]()
    var searching = false
    
    var friendsTemp = [Friends]()
    var friends: Results<Friends>? = DatabaseService.get(Friends.self)
    let friendsService = FriendsS()
    
    var notificationToken: NotificationToken?
    
    let realm = try? Realm()
    
    var friendSectionsVK = [String]()
    var friendDictVK = [String : [Friends]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        friendDictVK = [String : [Friends]]()
        let headerNib = UINib.init(nibName: "Header", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "Header")
        
        friendsService.loadListFriends() { [weak self] friends, error in
            guard let self = self, error == nil,
                let friends = friends else { print(error?.localizedDescription as Any); return }
            self.friends = self.realm?.objects(Friends.self)
            //            DispatchQueue.main.async {
            //                self.tableView.reloadData()
            //            }
            try? self.realm?.write {
                if self.friends != nil {
                    self.realm?.delete(self.friends!)
                }
            }
            try? DatabaseService.save(friends, update: true)
            self.generateFriendDictVK()
        }
    }
    
    func generateFriendDictVK() {
        for friend in friends! {
            var key = ""
            if friend.last_Name != "" {
                key = "\(String(describing: friend.last_Name.first!))"
            } else {
                key = "\(String(describing: friend.first_Name.first!))"
            }
            let lower = key
            
            if var friendValue = friendDictVK[lower] {
                friendValue.append(friend)
                friendDictVK[lower] = friendValue
            } else {
                friendDictVK[lower] = [friend]
            }
        }
        friendSectionsVK = [String](friendDictVK.keys)
        friendSectionsVK = friendSectionsVK.sorted()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationToken = friends?.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial(_):
                self.tableView.reloadData()
            case .update(_):
                self.tableView.reloadData()
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //}
    
    //extension AllNamesController: UITableViewDelegate, UITableViewDataSource {
    
    func configureView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        definesPresentationContext = true
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return friendSectionsVK.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friendKey = friendSectionsVK[section]
        if let wordValues = friendDictVK[friendKey] {
            return wordValues.count
        }
        return 0
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendSectionsVK
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as? AllNamesCell else { return UITableViewCell() }
        let friendKey = friendSectionsVK[indexPath.section]
        if let newValue = friendDictVK[friendKey] {
            print(newValue)
            cell.newsLabel.text = "\(newValue[indexPath.row].first_Name) \(newValue[indexPath.row].last_Name)"
            cell.newsPhoto.kf.setImage(with: FriendsS.urlForFriendVK(newValue[indexPath.row].avatar))
        }
        return cell
        //
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as? AllNamesCell,
        //            let friend = friends?[indexPath.row] else { return UITableViewCell() }
        //        cell.newsLabel.text = "\(friend.first_Name) \(friend.last_Name)"
        //        cell.newsPhoto.kf.setImage(with: URL(string: friend.avatar))
        //        return cell
        
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as? AllNamesCell,
        //            let friend = friends?[indexPath.row] else { return UITableViewCell() }
        //        cell.newsLabel.text = "\(friend.first_Name) \(friend.last_Name)"
        //        cell.newsPhoto.kf.setImage(with: URL(string: friend.avatar))
        //        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! Header
        headerView.lblTitle.text = friendSectionsVK[section]
        return headerView
    }
    
    
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "friendsPhotos" {
//                let friendsController = segue.source as! AllNamesController
//                let destenationVC = segue.destination as! FriendsViewContriller
//                if let indexPath = friendsController.tableView.indexPathForSelectedRow {
//                    let friendID = friends?[indexPath.row].name_Id
//                    let firstName = friends?[indexPath.row].first_Name
//                    let lastName = friends?[indexPath.row].last_Name
//                    if let friendID = friendID,
//                        let firstName = firstName,
//                        let lastName = lastName {
//                        destenationVC.name2 = String(friendID)
//                        destenationVC.userID = String(friendID)
//                        print(friendID)
//                        destenationVC.screenName = firstName + " " + lastName
//                    }
//                }
//            }
//        }
}

//extension AllNamesController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard !searchText.isEmpty else {
//            friends = filteredFriends
//            tableView.reloadData()
//            return
//        }
//        friends = friends.filter { $0.first_Name.range(of: searchText,  options: .caseInsensitive) != nil }
//        searching = true
//        tableView.reloadData()
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searching = false
//        searchBar.text = ""
//        tableView.reloadData()
//    }
//}

