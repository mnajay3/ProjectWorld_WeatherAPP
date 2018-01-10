//
//  MockServiceData.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 11/11/17.
//  Copyright © 2018 Naga Murala. All rights reserved.
//

import Foundation

public let kMockJsonValidResponse : JSON = [
    "main": [
        "humidity" : "81",
        "pressure" : "1012",
        "temp" : "280.32",
        "temp_max" : "281.15",
        "temp_min" : "279.15",
    ], "name": "London",
       "id": "2643743",
       "coord": [
        "lat" : "51.51",
        "lon" : "-0.13",
    ], "weather": [
        [
            "description" : "light intensity drizzle",
            "icon" : "09d",
            "id" : "300",
            "main" : "Drizzle",
        ]
    ],
       "clouds":
        [
            "all" : "90",
    ],
       "dt": "1485789600",
       "base": "stations",
       "sys": [
        "country" : "GB",
        "id" : "5091",
        "message" : "0.0103",
        "sunrise" : "1485762037",
        "sunset" : "1485794875",
        "type" : "1",
    ], "cod": "200", "visibility": "10000", "wind": [
        "deg" : "80",
        "speed" : "4.1",
    ]] as JSON ;

public let kMockEmptyJson : JSON = [:];

public let kMockJsonInValidWeatherMissing : JSON = [
    "main": [
        "humidity" : "81",
        "pressure" : "1012",
        "temp" : "280.32",
        "temp_max" : "281.15",
        "temp_min" : "279.15",
    ], "name": "London",
       "id": "2643743",
       "coord": [
        "lat" : "51.51",
        "lon" : "-0.13",
    ],
       "clouds":
        [
            "all" : "90",
    ],
       "dt": "1485789600",
       "base": "stations",
       "sys": [
        "country" : "GB",
        "id" : "5091",
        "message" : "0.0103",
        "sunrise" : "1485762037",
        "sunset" : "1485794875",
        "type" : "1",
    ], "cod": "200", "visibility": "10000", "wind": [
        "deg" : "80",
        "speed" : "4.1",
    ]] as JSON ;

public let kMockJsonInValidValues : JSON = [
    "main": [
        "humidity" : "81",
        "pressure" : "1012",
        "temp" : "280.32",
        "temp_max" : "Naga Murala", //"281.15",
        "temp_min" : "279.15",
    ], "name": "London",
       "id": "2643743",
       "coord": [
        "lat" : "51.51",
        "lon" : "-0.13",
    ],
       "clouds":
        [
            "all" : "90",
    ],
       "dt": "1485789600",
       "base": "stations",
       "sys": [
        "country" : "GB",
        "id" : "5091",
        "message" : "0.0103",
        "sunrise" : "1485762037",
        "sunset" : "1485794875",
        "type" : "1",
    ], "cod": "200", "visibility": "10000", "wind": [
        "deg" : "80",
        "speed" : "4.1",
    ]] as JSON ;

