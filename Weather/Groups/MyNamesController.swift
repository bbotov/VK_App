//
//  MyNamesController.swift
//  Weather
//
//  Created by Boris Botov on 11.11.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class MyNamesController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var filteredGroups = [GroupsVK]()
    var searching = false
    
    var groups: Results<GroupsVK>? = DatabaseService.get(GroupsVK.self)
    var notificationToken: NotificationToken?
    let groupsService = GroupsService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
//        filteredGroups = groups
        
        groupsService.loadListGroups() { [weak self] groups, error in
            guard let self = self, error == nil,
                let groups = groups else { print(error?.localizedDescription as Any); return }
            
            let realm = try? Realm()
            try? realm?.write {
                if self.groups != nil {
                    realm?.delete(self.groups!)
                }
            }
            
            try? DatabaseService.save(groups, update: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notificationToken = groups?.observe { [weak self] changes in
            guard let self = self else { return }
            switch changes {
            case .initial(_):
                self.tableView.reloadData()
            case .update(_, let dels, let ins, let mods):
                self.tableView.applyChanges(deletions: dels, insertions: ins, updates: mods)
            case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
    
//    @IBAction func add228(segue: UIStoryboardSegue) {
//
//        if segue.identifier == "add228" {
//
//            let allGroupController = segue.source as! FrGroupViewController
//
//            if let indexPath = allGroupController.tableView.indexPathForSelectedRow {
//
//                let name = allGroupController.groupsNew[indexPath.row]
////                let icon = allGroupController.Icon[indexPath.row]
//
//                if !groups.contains(name) {
//
//                    groups.append(name)
////                    Icon.append(icon!)
//
//                    tableView.reloadData()
//                }
//            }
//        }
//    }
}

extension MyNamesController: UITableViewDelegate, UITableViewDataSource {
    
    public func configureView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        definesPresentationContext = true
    }
    
//    public func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return groups?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyNameCell", for: indexPath) as? MyNamesCell, let group = groups?[indexPath.row] else { return UITableViewCell() }
        cell.friendName.text = group.name_Group
        cell.icon.kf.setImage(with: URL(string: group.icon_Group))
        return cell
    }
    
//    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            groups!.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
}

//extension MyNamesController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        guard !searchText.isEmpty else {
//            groups = filteredGroups
//            tableView.reloadData()
//            return
//        }
//        groups = groups.filter { $0.name_Group.range(of: searchText,  options: .caseInsensitive) != nil }
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
