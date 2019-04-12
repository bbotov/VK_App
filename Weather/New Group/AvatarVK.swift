//
//  AvatarVK.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 08.01.2019.
//  Copyright © 2019 Boris Botov. All rights reserved.
//

import UIKit

class AvatarVK: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowRadius = 2.5
//        layer.shadowOffset = CGSize.zero
        clipsToBounds = false
    }
}
