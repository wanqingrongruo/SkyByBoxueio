//
//  URLSession.swift
//  Sky
//
//  Created by roni on 2017/12/7.
//  Copyright © 2017年 Mars. All rights reserved.
//

import Foundation

extension URLSession: URLSessionProtocol {
    
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.dataTaskHandler) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask as URLSessionDataTaskProtocol
    }
}
