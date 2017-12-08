//
//  URLSessionProtocol.swift
//  Sky
//
//  Created by roni on 2017/12/7.
//  Copyright © 2017年 Mars. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    typealias dataTaskHandler = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping dataTaskHandler)
        -> URLSessionDataTaskProtocol
}
