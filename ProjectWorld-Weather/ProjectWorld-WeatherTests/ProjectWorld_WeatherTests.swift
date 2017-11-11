//
//  ProjectWorld_WeatherTests.swift
//  ProjectWorld-WeatherTests
//
//  Created by Naga Murala on 10/9/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import XCTest
@testable import ProjectWorld_Weather
@testable import ProjectWorldFramework

class ProjectWorld_WeatherTests: XCTestCase {
    
    let weatherVC = WeatherViewController()
    override func setUp() {
        super.setUp()
        weatherVC.pageName = "WeatherMainViewController"
        weatherVC.segueAlias = "weatherDetails"
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    //MARK:- Plist test cases
    func testPropertyListConfigs() {
        
        let testBundle = Bundle(for: ProjectWorld_WeatherTests.self)
        if let url = testBundle.url(forResource: RESOURCE_NAME, withExtension: PLIST),
            let myDict = NSDictionary(contentsOf: url) as? [String:Any] {
            XCTAssertNotNil(myDict[PAGE_CONFIGURATION])
        } else {
            XCTFail("Unable to find keyConfigurations in PLIST")
        }
    }
    func testWeatherInfoDetailViewName() {
        
        XCTAssertEqual(weatherVC._nextViewName, "weatherInformation")
    }
    func testWeatherInfoDetailDestinationVC() {
        XCTAssertEqual(weatherVC._nextstoryBoard, "Main")
    }
    
    func testAPIKeyFromPlist() {
        let plistUtil = MasterPListUtil()
        let apiKeyValue = plistUtil.findPlistValue(API_KEY, resourceName: RESOURCE_NAME)
        XCTAssertEqual(apiKeyValue, "42d4008c153e332cdbf908fa26df1d2e")
    }
    
    //ServiceTests
    func testOpenWeatherURLIsNotEmpty() {
        let url = weatherService.searchURLByCity(city: "San Antonio")
        XCTAssertNotNil(url)
    }
    func testOpenWeatherUrlForCity() {
        let url = weatherService.searchURLByCity(city: "San Antonio")
        XCTAssertEqual(url, URL(string: "http://samples.openweathermap.org/data/2.5/weather?q=San%20Antonio&appid=42d4008c153e332cdbf908fa26df1d2e"))
    }
    func testOpenWeatherService() {
        let url = weatherService.searchURLByCity(city: "San Antonio")
        weatherService.getWeatherInformation(url: url) { (resultData) in
            XCTAssertNotNil(resultData)
        }
    }
    
}
