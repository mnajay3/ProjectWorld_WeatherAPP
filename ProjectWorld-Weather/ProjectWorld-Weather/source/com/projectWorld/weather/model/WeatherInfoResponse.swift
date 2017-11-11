//
//  WeatherInfoResponse.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 11/9/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import UIKit

@objc class WeatherInfoResponse: NSObject, NSCoding {
    @objc var coord : LocationCoordinates?
    @objc var weather: [Weather]?
    @objc var base : String?
    @objc var main : MainWeatherInfo?
    @objc var visibility: NSNumber?
    @objc var wind : Wind?
    @objc var clouds : Cloud?
    @objc var dt : NSNumber?
    @objc var sys: SystemInternal?
    @objc var id: NSNumber?
    @objc var name: String?
    @objc var cod: NSNumber?
    @objc var weekDayName: String?
    @objc var imageIcon: UIImage?
    @objc var currentTime: Date?
    
    override func setValue(_ value: Any?, forKey key: String) {
        //This condition is to check if we have any extra values in json response that we don't have here in the model object.
        //This condition prevents the crash. for eg: If we have num_of_likes in response json but it's not there in this model object, without the follwoing condition the app will crash
        //breif: every iteration NSSelectorFromString forms a setter and self.responds return a boolean value either this model object can respond to this setter(check this object available in this model object)
        if self.responds(to: NSSelectorFromString(key)) {
            switch key {
            case "coord":
                self.coord = LocationCoordinates(json: value as? JSON)
            case "weather":
                if let weatherResponse = value as? [AnyObject] {
                    let weatherMap = weatherResponse.map({
                        //TODO: check this force unwrapping
                        Weather(json: $0 as? [String: AnyObject])
                    })
                    self.weather = weatherMap as? [Weather]
                }
            case "main":
                self.main = MainWeatherInfo(json: value as? JSON)
            case "wind":
                self.wind = Wind(json: value as? JSON)
            case "clouds":
                self.clouds = Cloud(json: value as? JSON)
            case "sys":
                self.sys = SystemInternal(json: value as? JSON)
            case "dt":
                super.setValue(value, forKey: key)
                if let timeInterval = value as? TimeInterval {
                    let date = Date(timeIntervalSince1970: timeInterval)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat  = "EEEE"//"EE" to get short style
                    weekDayName = dateFormatter.string(from: date)//"Sunday"
                }
           default:
                super.setValue(value, forKey: key)
            }
        }
    }
    //Failable initializer to return nil when no response data
    init?(json: JSON?) {
        super.init()
        guard let json = json else { return nil }
        self.setValuesForKeys(json)
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(self.main, forKey: "main")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        var jsonObj = JSON()
        jsonObj["name"] = aDecoder.decodeObject(forKey: "name") as AnyObject
        jsonObj["main"] = aDecoder.decodeObject(forKey: "main") as AnyObject
        self.init(json: jsonObj)
    }
}
