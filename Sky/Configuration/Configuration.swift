//
//  Configuration.swift
//  Sky
//
//  Created by roni on 2017/12/7.
//  Copyright © 2017年 Mars. All rights reserved.
//

import Foundation

struct API {
    static let key = "7a32180d838e036e07159904047e7fe1"
    static let baseUrl = URL(string: "https://api.darksky.net/forecast/")!
    static let authenticateUrl = baseUrl.appendingPathComponent(key)
}
