//
//  ProjectWorld_WeatherUITests.swift
//  ProjectWorld-WeatherUITests
//
//  Created by Naga Murala on 11/11/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import XCTest

class ProjectWorld_WeatherUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHappyPath() {
        
        let themeCollectionView = XCUIApplication().collectionViews.containing(.image, identifier:"theme").element
        themeCollectionView.tap()
        themeCollectionView.tap()
        themeCollectionView.tap()
        themeCollectionView.tap()
        
    }
    func testWeatherwithValidCity() {
        
        let app = XCUIApplication()
        app.collectionViews.containing(.image, identifier:"theme").element.tap()
        
        let collectionViewsQuery = app.collectionViews
        let textField = collectionViewsQuery.cells.otherElements.containing(.staticText, identifier:"London").children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .textField).element
        textField.waitForExistence(timeout: 2)
        textField.tap()
        textField.waitForExistence(timeout: 2)
        textField.typeText("San Antonio")
        textField.waitForExistence(timeout: 2)
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Find"]/*[[".cells.buttons[\"Find\"]",".buttons[\"Find\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        textField.waitForExistence(timeout: 2)
        
    }
    
    func testWeatherWithEmptyCity() {
        
        let app = XCUIApplication()
        app.collectionViews.containing(.image, identifier:"theme").element.tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Find"]/*[[".cells.buttons[\"Find\"]",".buttons[\"Find\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Required"].buttons["Click"].tap()
    }
    
    func testWeatherNavigateNextScreen() {
        let app = XCUIApplication()
        let collectionView = app.otherElements.containing(.button, identifier:"WeatherInformation").children(matching: .collectionView).element
        collectionView.waitForExistence(timeout: 2.0)
        collectionView.tap()
        collectionView.waitForExistence(timeout: 2.0)
        collectionView.tap()
        app.buttons["WeatherInformation"].tap()
        app.waitForExistence(timeout: 2.0)
        app.waitForExistence(timeout: 2.0)
        app.buttons["Back"].tap()
        app.waitForExistence(timeout: 2.0)
        
    }
    
}
