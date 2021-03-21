//
//  CurrentWeather.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 16.03.2021.
//

import Foundation
import SwiftUI

struct CurrentWeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
    let wind: Wind
}

struct Wind: Codable {
    let speed: Double
    let degree: Int
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
    }
}

struct Weather: Codable {
    let icon: String
    let description: String
    
}

struct Main: Codable {
    let temperature: Double
    let feelsLike: Double
    let humidity: Int
    let maxTemp: Double
    let minTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case humidity
        case maxTemp = "temp_max"
        case minTemp = "temp_min"
    }
}

