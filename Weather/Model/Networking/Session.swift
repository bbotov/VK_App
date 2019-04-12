//
//  Session.swift
//  WWeatherathWeatherr
//
//  Created by Boris Botov on 26.12.2018.
//  Copyright © 2018 Boris Botov. All rights reserved.
//

import UIKit

class Session {
    private init() { }
    
    public static let instance = Session()
    
    var token: String = ""
    var userld: Int = 0
}
