//
//  FrGroupViewController.swift
//  Weather
//
//  Created by Boris Botov on 11.11.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import UIKit
import Foundation

class FrGroupViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var groupsNew = [GroupsNewVK]()
    let groupsNewService = GroupsNewVKService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
}

extension FrGroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func configureView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        definesPresentationContext = true
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupsNew.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsGroup", for: indexPath) as! FrGroupViewCell
        let groupNew = groupsNew[indexPath.row]
        
        cell.friendGroup.text = groupNew.name_Group
        cell.icon.kf.setImage(with: URL(string: groupNew.icon_Group))
        
        return cell
    }
}

extension FrGroupViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        groupsNewService.loadListGroupsNew(searchText: searchText) { [weak self] groupsNew, error in
            guard let self = self, error == nil,
                let groupsNew = groupsNew else { print(error?.localizedDescription as Any); return }
            
            self.groupsNew = groupsNew
            self.tableView.reloadData()
        }
    }
}
