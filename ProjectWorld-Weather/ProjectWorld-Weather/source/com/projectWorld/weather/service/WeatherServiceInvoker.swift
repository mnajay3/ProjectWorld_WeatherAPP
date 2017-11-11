//
//  WeatherServiceInvoker.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 11/9/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

//Created a protocol to set some behavior(rules) to the clients, that must confirm(obey) to it
import UIKit
import ProjectWorldFramework

public typealias JSON = [String: AnyObject]

//Singleton desing Pattern
//I am using Singleton pattern, since I don't want to allow clients to create multiple object to rushOver the my service invoker.
//It acts lik a pipe with only one bus that will transform the data (Client - Server)
let weatherService = WeatherServiceInvoker.singltonObject

class WeatherServiceInvoker: NSObject {
    //Applying even more security not to touch my Service invoker class from outside.. everyone has to use  weatherService from this file
    fileprivate static let singltonObject = WeatherServiceInvoker()
    //Made the Init method private to conform to Singleton pattern
    private override init() { super.init() }
    
    func searchURLByCity(city: String) -> URL? {
        let escapedCityString = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let escapedCity = escapedCityString else
        {
            print("ProjectWorld:Something wrong in the URL")
            return nil
        }
        //PLIST Functionality providing by ProjectWorldFramwork api.Get the Weather API key from PLIST
        let apiValue = MasterPListUtil().findPlistValue(API_KEY, resourceName: RESOURCE_NAME)
        if let apiValue = apiValue {
            return URL(string: WEATHER_URL_STRING + "?q=\(String(describing: escapedCity))&appid=\(apiValue)")
        }
        return nil
    }
    
    func urlForIcon(iconString: String?) -> URL? {
        guard let iconString = iconString else {
            return nil
        }
        return URL(string: WEATHER_ICON_URL_STRING+"\(iconString).png")!
    }
    
    //should use escaping since the completion block will not execute right away some where at the middle of the closure
    func getWeatherInformation(url: URL?, completion: @escaping (Data) -> ()) {
        //Using guard, Safe unwrapping the optional value to avoid nil value unwrapping and unwanted app crashes
        guard let url = url else { return }
        masterTaskMgmt.performTask(url: url, block: {
            //NOOP
        }) { (data) in
            completion(data)
        }
    }
}



