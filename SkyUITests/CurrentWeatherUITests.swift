//
//  CurrentWeatherUITests.swift
//  SkyUITests
//
//  Created by roni on 2017/12/11.
//  Copyright © 2017年 Mars. All rights reserved.
//

import XCTest

class CurrentWeatherUITests: XCTestCase {
    
    var app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        app.launchArguments += ["UI-TESTING"]
        let json = """
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
"""
        app.launchEnvironment["FakeJSON"] = json
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_location_button_exists() {
        let locationBtn = app.buttons["LocationBtn"]
        //        let exists = NSPredicate(format: "exists == true")
        //
        //        expectation(for: exists, evaluatedWith: locationBtn, handler: nil)
        //        waitForExpectations(timeout: 5, handler: nil)
        //                XCTAssert(locationBtn.exists)
        XCTAssert(locationBtn.exists)
    }
    
    func test_currently_weather_display() {
        XCTAssert(app.images["snow"].exists)
        XCTAssert(app.staticTexts["Light Snow"].exists)
    }
    
}
