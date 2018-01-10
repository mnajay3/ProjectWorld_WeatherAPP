//
//  WeatherViewModel.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 01/09/18.
//  Copyright © 2018 Naga Murala. All rights reserved.
//

import UIKit
//ViewModel, solely responsible for all the business logic. It takes care of fetching the network resonse using service invoker class and parse it and map it to model objects.
//It takes care of storing the current response object into userdefaults, fetching it based upon condition and time iterval basis
//Delegate design pattern
//Intentionally I am using delegation pattern intentionally since I don't want to tightly coupled with service invoker and invoking service is not only the part I am gonna do in the ViewModel.
//With this delegation pattern I am conforming to some of the behaviors providing by the delegate. So that it can hand off me some encapsulate object(network response in this case) then I will map it to model object
class WeatherViewModel: NSObject {
    
    var weatherInfoResponse: WeatherInfoResponse?
    var weatherImage: UIImage?
    var numOfItemsInSection = 1
    var weatherDictionary: JSON = {
        return JSON()
    }()
    lazy var persistSearch : UserDefaults = UserDefaults.standard
    
    
    override init() {
        super.init()
    }
    
    func getWeatherInfo(city: String, completion: @escaping () -> ()) {
        //Check if the value is already available in userdefaults. Do not call the service if the data is available in userdefaults
        //Since WeatherApp account is unpaid, city always should be London
        var responseData: WeatherInfoResponse?
        if let encodedResponse = UserDefaults.standard.object(forKey: "weatherInfoResponseObject") as? Data {
             responseData = try! PropertyListDecoder().decode(WeatherInfoResponse.self, from: encodedResponse)
        }
        //Make sure to call network service if the previous search passed 4 hours and with the same city name
        if responseData != nil && responseData?.name == city && !canCallWeatherAPI() {
            self.weatherInfoResponse = responseData
            completion()
        }
        else {
            //Invoke Service to fetch network response, if the information is not available in Userdefaults
            let url = weatherService.searchURLByCity(city: city)
            weatherService.getWeatherInformation(url: url) { (resultData) in
                do {
                    //Calling the delegate method first to have some brushups before calling the completion block
                    self.weatherInfoResponse = try JSONDecoder().decode(WeatherInfoResponse.self, from: resultData)
                    //Make sure to run it in mainthread, we use it for UI updates after finishing the service call
                    DispatchQueue.main.async { [unowned self] in
                        do {
                            try self.persistSearch.set(PropertyListEncoder().encode(self.weatherInfoResponse), forKey: "weatherInfoResponseObject")
                        }catch let err {
                            print("Something wrong while storing it to UserDefaults",err.localizedDescription)
                        }
                        let loginTime = Date()
                        UserDefaults.standard.set(loginTime, forKey: "prevSearchTime")
                        completion()
                    }
                } catch let jsonErr {
                    print(jsonErr.localizedDescription)
                }
            }
        }
    }
    
    func getWeatherImage(completionHandler: @escaping ()->()) {
        guard let  weather = self.weatherInfoResponse?.weather, weather.count > 0 else { return }
        let url = weatherService.urlForIcon(iconString: weather[0].icon)
        weatherService.getWeatherInformation(url: url) { [unowned self](resultData) in
            DispatchQueue.main.async { [unowned self] in
                guard let image = UIImage(data: resultData) else { return }
                self.weatherImage = image
                completionHandler()
            }
        }
    }
    
    //Method to decide, to call weather api or not
    func canCallWeatherAPI() -> Bool {
        //Check the userdefaults for the key, if not assign the current time
        let preSearchTime = UserDefaults.standard.object(forKey: "prevSearchTimes") as? Date ?? Date()
        let searchInterval = -preSearchTime.timeIntervalSinceNow
        //Checking if less than 5 seconds there is no value in userdefaults
        if searchInterval < 5.0 || (searchInterval / 3600) >= 4.0 {
            return true
        }
        return false
    }
}

