//
//  CloseButton.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 02.12.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import UIKit

class CloseButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 20
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.5
        layer.shadowOffset = CGSize.zero
        clipsToBounds = false
    }
}
