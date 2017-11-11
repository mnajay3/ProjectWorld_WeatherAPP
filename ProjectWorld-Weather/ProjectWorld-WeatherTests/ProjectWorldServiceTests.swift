//
//  ProjectWorldServiceTests.swift
//  ProjectWorld-WeatherTests
//
//  Created by Naga Murala on 11/11/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import XCTest
@testable import ProjectWorldFramework
@testable import ProjectWorld_Weather

class ProjectWorldServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK:- Positive TestCases
    func testServiceWithJsonValidDataBool() {
        let viewModal = WeatherViewModel()
        viewModal.setWeatherInformation(json: kMockJsonValidResponse)
        XCTAssertNotNil(viewModal.weatherInfoResponse)
    }
    
    func testServiceWithJsonValidDataWeather() {
        let viewModal = WeatherViewModel()
        viewModal.setWeatherInformation(json: kMockJsonValidResponse)
        XCTAssertNotNil(viewModal.weatherInfoResponse?.weather)
    }
    
    func testServiceWithJsonValidDataMain() {
        let viewModal = WeatherViewModel()
        viewModal.setWeatherInformation(json: kMockJsonValidResponse)
        XCTAssertNotNil(viewModal.weatherInfoResponse?.main)
    }
    
    func testServiceWithJsonValidData() {
        let viewModal = WeatherViewModel()
        viewModal.setWeatherInformation(json: kMockJsonValidResponse)
        XCTAssertEqual(viewModal.weatherInfoResponse?.name, "London")
    }
    
    func testServiceWithJsonValidDataSys() {
        let viewModal = WeatherViewModel()
        viewModal.setWeatherInformation(json: kMockJsonValidResponse)
        XCTAssertNotNil(viewModal.weatherInfoResponse?.sys)
    }
    
    func testServiceWithJsonValidCountry() {
        let viewModal = WeatherViewModel()
        viewModal.setWeatherInformation(json: kMockJsonValidResponse)
        XCTAssertEqual(viewModal.weatherInfoResponse?.sys?.country, "GB")
    }
    
    //MARK:- JSON with Empty Resposne
    func testServiceWithEmptyJson() {
        let viewModal = WeatherViewModel()
        viewModal.setWeatherInformation(json: JSON())
        XCTAssertNotNil(viewModal.weatherInfoResponse)
    }
    
    func testServiceWithEmptyJsonMain() {
        let viewModal = WeatherViewModel()
        viewModal.setWeatherInformation(json: JSON())
        XCTAssertNil(viewModal.weatherInfoResponse?.main)
    }
    
    //Negative Test cases
    func testServiceWithMissingWeatherJson() {
        let viewModal = WeatherViewModel()
        viewModal.setWeatherInformation(json: kMockJsonInValidWeatherMissing)
        XCTAssertNil(viewModal.weatherInfoResponse?.weather)
        XCTAssertNotNil(viewModal.weatherInfoResponse?.main)
    }
    func testServiceWithMissingWeatherJsonMainCheck() {
        let viewModal = WeatherViewModel()
        viewModal.setWeatherInformation(json: kMockJsonInValidWeatherMissing)
        XCTAssertNotNil(viewModal.weatherInfoResponse?.main)
    }
    
    func testServiceWithMissingValuesInJson() {
        let viewModal = WeatherViewModel()
        viewModal.setWeatherInformation(json: kMockJsonInValidValues)
        XCTAssertNotNil(viewModal.weatherInfoResponse?.main)
    }
    
    func testServiceWithMissingValuesInJsonGetValue() {
        let viewModal = WeatherViewModel()
        viewModal.setWeatherInformation(json: kMockJsonInValidValues)
        XCTAssertNotNil(viewModal.weatherInfoResponse?.main?.temp_max)
    }
    
}
