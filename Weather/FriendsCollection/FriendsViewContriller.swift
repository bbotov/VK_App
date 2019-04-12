//
//  FriendsViewContriller.swift
//  Weather
//
//  Created by Boris Botov on 11.11.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import UIKit
import Photos
import Kingfisher

class FriendsViewContriller: UICollectionViewController {

    @IBAction func scrollImage(_ sender: UIButton) {
        self.performSegue(withIdentifier: "imageScroll", sender: self)
    }
    
    let userVKPhotosService = PhotosVKService()
    var photos = [PhotosVK]()
    var name2 = ""
    
    var userID = ""
    var screenName = ""
    var photoIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userVKPhotosService.loadListPhotosVK(for: userID) {  [weak self]  (photos, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let photos = photos, let self = self else { return }
            
            self.photos = photos
            
            self.title = self.screenName
            
            self.collectionView.reloadData()
        }
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as! FriendsCell
        
        cell.icon.kf.setImage(with: PhotosVKService.urlForUserVKPhoto(photos[indexPath.row].url))
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = photos[indexPath.item]
        photoIndex = indexPath.item
        performSegue(withIdentifier: "imageScroll", sender: image)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPhotoPageView" {
            let destinationVC = segue.destination as! ImageScroll
            destinationVC.image = (sender as? String)
            destinationVC.photos = self.photos
            destinationVC.photoIndex = self.photoIndex
            destinationVC.userID = self.userID
            let photoId = photos[photoIndex].id
            destinationVC.photoID = String(photoId)
            // Добавляем строчку с проверкой нужного идентификатора, чтобы передать массив photos
        } else if segue.identifier == "imageScroll" {
            guard let destinationVC = segue.destination as? ImageScroll else { return }
            destinationVC.photos = photos
        }
    }
    

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}
