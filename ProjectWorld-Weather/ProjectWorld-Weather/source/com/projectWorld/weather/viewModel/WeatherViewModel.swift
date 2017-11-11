//
//  WeatherViewModel.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 11/9/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import UIKit
//Delegate design pattern
//Intentionally I am using delegation pattern intentionally since I don't want to tightly coupled with service invoker and invoking service is not only the part I am gonna do in the ViewModel.
//With this delegation pattern I am conforming to some of the behaviors providing by the delegate. So that it can hand off me some encapsulate object(network response in this case) then I will map it to model object
class WeatherViewModel: NSObject {
    
    var weatherInfoResponse: WeatherInfoResponse?
    var numOfItemsInSection = 1
    var weatherDictionary: JSON = {
        return JSON()
    }()
    
    
    override init() {
        super.init()
    }
    
    func getWeatherInfo(city: String, completion: @escaping () -> ()) {
        //Invoke Service to fetch network response
        let url = weatherService.searchURLByCity(city: city)
        weatherService.getWeatherInformation(url: url) { (resultData) in
            do {
                guard  let json = try JSONSerialization.jsonObject(with: resultData, options: []) as? JSON else { return }
                DispatchQueue.main.async { [unowned self] in
                    //Calling the delegate method first to have some brushups before calling the completion block
                    self.setWeatherInformation(json : json)
                    //Most of the cases, we use it for UI updates after finishing the service call
                    completion()
                }
            }catch let jsonErr{
                print(jsonErr.localizedDescription)
            }
        }
    }
    
    //This gets called even before the compleion block, if member wants to perfom any assignments just before the completio block
    func setWeatherInformation(json: JSON) {
        /**
         KVO:KeyValue Observing design pattern
         Here I am following KVO pattern
         **/
        self.weatherInfoResponse = WeatherInfoResponse(json: json)
    }
    
    func getWeatherImage(completionHandler: @escaping ()->()) {
        guard let  weather = self.weatherInfoResponse?.weather, weather.count > 0 else { return }
        let url = weatherService.urlForIcon(iconString: weather[0].icon)
        weatherService.getWeatherInformation(url: url) { [unowned self](resultData) in
            DispatchQueue.main.async { [unowned self] in
                guard let image = UIImage(data: resultData) else { return }
                self.weatherInfoResponse?.imageIcon = image
                completionHandler()
            }
        }
    }
}

