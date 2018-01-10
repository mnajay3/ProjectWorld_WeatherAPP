//
//  WeatherInfoResponse.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 01/09/18.
//  Copyright © 2018 Naga Murala. All rights reserved.
//

import UIKit

struct WeatherInfoResponse: Codable {
    var coord : LocationCoordinates?
    var weather: [Weather]?
    var base : String?
    var main : MainWeatherInfo?
    var visibility: Int?
    var wind : Wind?
    var clouds : Cloud?
    var dt : Double?
    var sys: SystemInternal?
    var id: Int?
    var name: String?
    var cod: Int?
    var currentTime: Date?
}

