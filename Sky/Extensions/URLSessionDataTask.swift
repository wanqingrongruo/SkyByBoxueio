//
//  URLSessionDataTask.swift
//  Sky
//
//  Created by roni on 2017/12/7.
//  Copyright © 2017年 Mars. All rights reserved.
//

import Foundation

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

internal class DarkSkyURLSessionDataTask
: URLSessionDataTaskProtocol {
    private let request: URLRequest
    private let completion: DataTaskHandler
    
    init(request: URLRequest, completion: @escaping DataTaskHandler) {
        self.request = request
        self.completion = completion
    }
    
    func resume() {
        let json = ProcessInfo
            .processInfo
            .environment["FakeJSON"]
        
        if let json = json {
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil)
            let data = json.data(using: .utf8)!
            
            completion(data, response, nil)
        }
    }
}
