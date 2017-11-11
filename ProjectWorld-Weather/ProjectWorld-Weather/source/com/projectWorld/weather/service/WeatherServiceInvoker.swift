//
//  WeatherServiceInvoker.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 11/9/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

//Created a protocol to set some behavior(rules) to the clients, that must confirm(obey) to it
import UIKit
protocol WeatherServiceInvokerDelegate {
    //delegate method, Whic is used for assignments.
    func setWeatherInformation(json: JSON)
}
//Singleton desing Pattern
//I am using Singleton pattern, since I don't want to allow clients to create multiple object to rushOver the my service invoker.
//It acts lik a pipe with only one bus that will transform the data (Client - Server)
let weatherService = WeatherServiceInvoker.singltonObject
typealias JSON = [String: AnyObject]
class WeatherServiceInvoker: NSObject {
    //Applying even more security not to touch my Service invoker class from outside.. everyone has to use  weatherService from this file
    fileprivate static let singltonObject = WeatherServiceInvoker()
    
    //Made the Init method private to conform to Singleton pattern
    private override init() {
        super.init()
    }
    //delegte, Every client should delegate themselves to this property to conform to the protocol methods
    var serviceDelegate: WeatherServiceInvokerDelegate?
    
    
    func searchURLByCity(city: String) -> URL? {
        let escapedCityString = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let escapedCity = escapedCityString else { print("ProjectWorld:Something wrong in the URL"); return nil }
        return URL(string: WEATHER_URL_STRING + "?q=\(String(describing: escapedCity))&appid=\(API_KEY)")
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
        //Using URLSession for network call by passing url. It's a task management(multiThreading), excute the url in backgroung thread. Once we get the response(data, response, error). We have to handle it and get the Main thread to the top to update the User Interactive information.
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error while invoking the service")
                return
            }
            guard let data = data else {
                print(error?.localizedDescription ?? "Error in network data")
                return
            }
            completion(data)
            
            }.resume()  //Make sure to resume the service task to get invoked
    }
}



