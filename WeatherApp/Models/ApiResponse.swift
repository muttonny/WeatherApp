//
//  ApiResponse.swift
//  WeatherApp
//
//  Created by Tony Mut on 10/8/22.
//

import UIKit

struct ApiResponse : Codable {
    
    var cod: Int?
    var message: String?
    var dt: Double?
    var main: WeatherInfo?
    var clouds: Clouds?
    var weather: [WeatherDescription]?
}

struct ForecastResponse: Codable {
    
    var cod: String?
    //var message: String?
    var main: WeatherInfo?
    var clouds: Clouds?
    var weather: [WeatherDescription]?
    var list: [WeatherData]?
}

struct WeatherInfo: Codable {
    var temp: Float?
    var feels_like: Float?
    var temp_min: Float?
    var temp_max: Float?
    var pressure: Int?
    var humidity: Int?
}

struct Clouds: Codable {
    var all: Int?
}

struct WeatherDescription: Codable {
    var id: Int?
    var main: String?
    var description: String?
}

struct WeatherData: Codable {
    var dt: Double?
    var main: WeatherInfo?
    var clouds: Clouds?
    var weather: [WeatherDescription]?
}
