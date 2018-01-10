//
//  LocationCoordinates.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 01/09/18.
//  Copyright © 2018 Naga Murala. All rights reserved.
//

import UIKit

struct LocationCoordinates: Codable {
    var lon: Double?
    var lat: Double?
}

struct Weather: Codable {
    var id: Int?
    var main: String?
    var mainDescription: String?
    var icon: String?
}

struct MainWeatherInfo: Codable {
    var temp: Double?
    var pressure: Int?
    var humidity: Int?
    var temp_min: Double?
    var temp_max: Double?
}

struct Wind: Codable {
    var speed: Double?
    var deg: Int?
}

struct Cloud: Codable {
    var all: Int?
}

struct SystemInternal: Codable {
    var type: Int?
    var id: Int?
    var message: Double?
    var country: String?
    var sunrise: Int?
    var sunset: Int?
}



