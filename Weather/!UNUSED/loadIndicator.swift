//
//  loadIndicator.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 02.12.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import UIKit

class loadIndicator: UIView {
    
    let point1 = UIView(frame: CGRect(x: -6, y: 0, width: 20, height: 20))
    let point2 = UIView(frame: CGRect(x: 15, y: 0, width: 20, height: 20))
    let point3 = UIView(frame: CGRect(x: 36, y: 0, width: 20, height: 20))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        point1.layer.backgroundColor = UIColor.black.cgColor
        point1.layer.cornerRadius = bounds.width / 5
        point2.layer.backgroundColor = UIColor.black.cgColor
        point2.layer.cornerRadius = bounds.width / 5
        point3.layer.backgroundColor = UIColor.black.cgColor
        point3.layer.cornerRadius = bounds.width / 5
        
        addSubview(point1)
        addSubview(point2)
        addSubview(point3)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.point1.alpha = 0.2
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.25, options: [.repeat, .autoreverse], animations: {
            self.point2.alpha = 0.2
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [.repeat, .autoreverse], animations: {
            self.point3.alpha = 0.2
        }, completion: nil)
    }
}
