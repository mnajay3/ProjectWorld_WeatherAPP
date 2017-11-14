//
//  LocationCoordinates.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 11/9/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import UIKit
/** Intentionally using KVO and KVC design patterns. Trying to use all the possible ways of mapping
 I will use Codable protocol swift4 beauty in next service call and object mapping..
 **/
class LocationCoordinates: NSObject, NSCoding {
    @objc var lon: NSNumber?
    @objc var lat: NSNumber?
    override func setValue(_ value: Any?, forKey key: String) {
        if self.responds(to: NSSelectorFromString(key)) {
            super.setValue(value, forKey: key)
        }
    }
    init?(json : JSON?) {
        super.init()
        guard let json = json else { return nil }
        setValuesForKeys(json)
    }
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: "name")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let jsonObj = JSON()
//        jsonObj["name"] = aDecoder.decodeObject(forKey: "name") as AnyObject
        self.init(json: jsonObj)
    }
}

class Weather: NSObject, NSCoding {
    @objc var id: NSNumber?
    @objc var main: String?
    @objc var mainDescription: String?
    @objc var icon: String?
    override func setValue(_ value: Any?, forKey key: String) {
        if self.responds(to: NSSelectorFromString(key)) {
            //Had to set this primitive String since, the response object description is already avialble in NSObject objc class
            if key == "description" {
                self.mainDescription = value as? String ?? ""
            }
            else {
                super.setValue(value, forKey: key)
            }
        }
    }
    init?(json: JSON?) {
        super.init()
        guard let json = json else { return nil }
        setValuesForKeys(json)
    }
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: "name")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let jsonObj = JSON()
//        jsonObj["name"] = aDecoder.decodeObject(forKey: "name") as AnyObject
        self.init(json: jsonObj)
    }
}

@objc class MainWeatherInfo: NSObject, NSCoding {
    @objc var temp: NSNumber?
    @objc var pressure: NSNumber?
    @objc var humidity: NSNumber?
    @objc var temp_min: NSNumber?
    @objc var temp_max: NSNumber?
    override func setValue(_ value: Any?, forKey key: String) {
        if self.responds(to: NSSelectorFromString(key)) {
            super.setValue(value, forKey: key)
        }
    }
    init?(json: JSON?) {
        super.init()
        guard let json = json else { return nil }
        setValuesForKeys(json)
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(temp, forKey: "temp")
        aCoder.encode(pressure, forKey: "pressure")
        aCoder.encode(humidity, forKey: "humidity")
        aCoder.encode(temp_min, forKey: "temp_min")
        aCoder.encode(temp_max, forKey: "temp_max")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        var jsonObj = JSON()
        jsonObj["temp"] = aDecoder.decodeObject(forKey: "temp") as AnyObject
        jsonObj["pressure"] = aDecoder.decodeObject(forKey: "pressure") as AnyObject
        jsonObj["humidity"] = aDecoder.decodeObject(forKey: "humidity") as AnyObject
        jsonObj["temp_min"] = aDecoder.decodeObject(forKey: "temp_min") as AnyObject
        jsonObj["temp_max"] = aDecoder.decodeObject(forKey: "temp_max") as AnyObject
        self.init(json: jsonObj)
    }
}

class Wind: NSObject, NSCoding {
    @objc var speed: NSNumber?
    @objc var deg: NSNumber?
    override func setValue(_ value: Any?, forKey key: String) {
        if self.responds(to: NSSelectorFromString(key)) {
            super.setValue(value, forKey: key)
        }
    }
    init?(json: JSON?) {
        super.init()
        guard let json = json else { return nil }
        setValuesForKeys(json)
    }
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: "name")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let jsonObj = JSON()
//        jsonObj["name"] = aDecoder.decodeObject(forKey: "name") as AnyObject
        self.init(json: jsonObj)
    }
}

class Cloud: NSObject, NSCoding {
    @objc var all: NSNumber?
    override func setValue(_ value: Any?, forKey key: String) {
        if self.responds(to: NSSelectorFromString(key)) {
            super.setValue(value, forKey: key)
        }
    }
    init?(json: JSON?) {
        super.init()
        guard let json = json else { return nil }
        setValuesForKeys(json)
    }
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: "name")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let jsonObj = JSON()
//        jsonObj["name"] = aDecoder.decodeObject(forKey: "name") as AnyObject
        self.init(json: jsonObj)
    }
}

class SystemInternal: NSObject, NSCoding {
    @objc var type: NSNumber?
    @objc var id: NSNumber?
    @objc var message: NSNumber?
    @objc var country: String?
    @objc var sunrise: NSNumber?
    @objc var sunset: NSNumber?
    override func setValue(_ value: Any?, forKey key: String) {
        if self.responds(to: NSSelectorFromString(key)) {
            super.setValue(value, forKey: key)
        }
    }
    init?(json: JSON?) {
        super.init()
        guard let json = json else { return nil }
        setValuesForKeys(json)
    }
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(name, forKey: "name")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let jsonObj = JSON()
//        jsonObj["name"] = aDecoder.decodeObject(forKey: "name") as AnyObject
        self.init(json: jsonObj)
    }
}


