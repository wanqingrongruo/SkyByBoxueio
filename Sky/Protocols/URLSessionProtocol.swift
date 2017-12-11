//
//  URLSessionProtocol.swift
//  Sky
//
//  Created by roni on 2017/12/7.
//  Copyright © 2017年 Mars. All rights reserved.
//

import Foundation

typealias DataTaskHandler = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping DataTaskHandler)
        -> URLSessionDataTaskProtocol
}
