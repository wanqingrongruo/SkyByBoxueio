//
//  WeatherDataManageTest.swift
//  SkyTests
//
//  Created by roni on 2017/12/7.
//  Copyright © 2017年 Mars. All rights reserved.
//

import XCTest
@testable import Sky  // 导入项目的 main module

class WeatherDataManageTest: XCTestCase {
    
    let url = URL(string: "https://darksky.net")!
    var session: MockURLSession!
    var manager: WeatherDataManager!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // 所有的测试前要准备的代码写在这里
        self.session = MockURLSession()
        self.manager = WeatherDataManager(baseURL: url, urlSession: session)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        // 测试后需要清理的代码写在这里 --  warnning: 必须写在 super.tearDown() 前面 !!!!
        super.tearDown()
        
       
    }
    
    
    // 默认的两个测试方法 -- 可删
    // 所有的测试方法必须用 test 开头, xcode 才会识别它们并自动执行
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    
    func test_weatherDataAt_starts_the_session() {
        let dataTask = MockURLSessionDataTask()
        session.sessionDataTask = dataTask
        
        manager.weatherDataAt(
            latitude: 52,
            longitude: 100,
            completion: { _, _ in  })
        
        XCTAssert(session.sessionDataTask.isResumeCalled)
    }
    
    func test_weatherDataAt_handle_invalid_request() {
        session.responseError = NSError(
            domain: "Invalid Request", code: 100, userInfo: nil)
        var error: DataManagerError? = nil
        
        manager.weatherDataAt(latitude: 52, longitude: 100, completion: {
            (_, e) in
            error = e
        })
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
    }
    
    func test_weatherDataAt_handle_statuscode_not_equal_to_200() {
        session.responseHeader = HTTPURLResponse(
            url: url, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let data = "{}".data(using: .utf8)!
        session.responseData = data
        
        var error: DataManagerError? = nil
        
        manager.weatherDataAt(latitude: 52, longitude: 100, completion: {
            (_, e) in
            error = e
        })
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
    }
    
    func test_weatherDataAt_handle_invalid_response() {
        session.responseHeader = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)
        
        let data = "{".data(using: .utf8)!
        session.responseData = data
        
        var error: DataManagerError? = nil
        
        manager.weatherDataAt(
            latitude: 52,
            longitude: 100,
            completion: {
                (_, e) in
                error = e
        })
        
        XCTAssertEqual(error, DataManagerError.invalidResponse)
    }
    
    func test_weatherDataAt_handle_response_decode() {
        session.responseHeader = HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)
        
        let data = """
    {
        "longitude" : 100,
        "latitude" : 52,
        "currently" : {
            "temperature" : 23,
            "humidity" : 0.91,
            "icon" : "snow",
            "time" : 1507180335,
            "summary" : "Light Snow"
        }
    }
    """.data(using: .utf8)!
        session.responseData = data
        
        var decoded: WeatherData? = nil
        
        manager.weatherDataAt(
            latitude: 52,
            longitude: 100,
            completion: {
                (d, _) in
                decoded = d
        })
        
        let expected = WeatherData(
            latitude: 52,
            longitude: 100,
            currently: WeatherData.CurrentWeather(
                time: Date(timeIntervalSince1970: 1507180335),
                summary: "Light Snow",
                icon: "snow",
                temperature: 23,
                humidity: 0.91))
        
        XCTAssertEqual(decoded, expected)
    }
}

//MARK: -  Document about testable
extension WeatherDataManageTest {
    /*:
     * ## 进行单元测试的一个重要前提，就是我们要测试的代码是“可测试”的. 所谓“可测试”，是指代码的测试要满足一些条件，包括：
     * 测试过程要不依赖于任何外部条件和系统；
     * 在任何环境、测试任意多次，结果应该保持不变；
     */
    
    /**
     * ## 对单元测试的具体认识
     * 每一个测试用例，应该只测试一个内容，例如：测试resume()方法是否被调用了
     * 对于不属于我们自己的代码，例如：系统API、第三方框架等，我们要mock掉相关的代码以隔离它们对测试过程的影响；
     */

}
