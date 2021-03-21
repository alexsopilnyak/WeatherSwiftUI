//
//  CurrentWeather.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 19.03.2021.
//

import Foundation
import SwiftUI

struct CurrentWeather: Identifiable {
    let id = UUID()
    let city: String
    let temperature: Double
    let icon: Image
    let feelsLike: Double
    let description: String
    let humidity: Int
    let windSpeed: Double
    
    private let windAngle: Int
    
    var windDirection: String {
        
        if windAngle >= 337 || windAngle < 23 {
            return "N"
        }
        if windAngle < 67 {
            return "NE"
        }
        if windAngle < 113 {
            return "E"
        }
        if windAngle < 157 {
            return "SE"
        }
        if windAngle < 203 {
            return "S"
        }
        if windAngle < 247 {
            return "SW"
        }
        if windAngle < 293 {
            return "W"
        }
        return "NW"
    }
    
    init(_ currentWeatherResponse: CurrentWeatherResponse) {
        self.city = currentWeatherResponse.name
        self.temperature = currentWeatherResponse.main.temperature
        self.feelsLike = currentWeatherResponse.main.feelsLike
        
        self.windSpeed = currentWeatherResponse.wind.speed
        self.windAngle = currentWeatherResponse.wind.degree
        self.humidity = currentWeatherResponse.main.humidity
        
        if let weather = currentWeatherResponse.weather.first {
            self.icon = ImageManager.icon(for: weather.icon)
            self.description = weather.description
        } else {
            self.icon = .init(systemName: "sun.max")
            self.description = "Very Cold"
        }
    }
    
}

