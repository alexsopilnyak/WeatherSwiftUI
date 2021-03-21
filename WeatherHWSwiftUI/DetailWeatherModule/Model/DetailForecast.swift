//
//  DetailWeather.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 19.03.2021.
//

import Foundation
import SwiftUI

struct DetailForecast {
    var forecast: [WeatherForecast]
    
    init(from dailyForecastResponse: DailyWeatherResponse) {
        forecast = dailyForecastResponse.list.map {
            WeatherForecast.init(from: $0)
        }
    }
}

struct WeatherForecast: Identifiable {
    let id = UUID()
    let minTemp: Double
    let maxTemp: Double
    
    private let date: Double
    private let iconDescription: String
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        return formatter.string(from: Date(timeIntervalSince1970: date))
    }
    
    var icon: Image {
        ImageManager.icon(for: iconDescription)
    }
    
    init(from item: DailyWeatherResponse.Item) {
        self.iconDescription = item.weather.description
        self.date = item.date
        self.minTemp = item.main.minTemp
        self.maxTemp = item.main.maxTemp
    }
}

extension WeatherForecast: Hashable {
    static func == (lhs: WeatherForecast, rhs: WeatherForecast) -> Bool {
        return lhs.dateString == rhs.dateString
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.dateString)
    }
}
