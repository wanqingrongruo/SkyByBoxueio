//
//  MockURLSession.swift
//  SkyTests
//
//  Created by roni on 2017/12/7.
//  Copyright © 2017年 Mars. All rights reserved.
//

import Foundation
@testable import Sky


class MockURLSession: URLSessionProtocol {
    var sessionDataTask = MockURLSessionDataTask()
    var responseData: Data?
    var responseHeader: HTTPURLResponse?
    var responseError: Error?
    
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.dataTaskHandler) -> URLSessionDataTaskProtocol {
        completionHandler(responseData, responseHeader, responseError)
        return sessionDataTask
    }
}
