//
//  DetailWeatherForecast.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 17.03.2021.
//

import Foundation

struct DailyWeatherResponse: Codable {
  let list: [Item]
  
  struct Item: Codable {
    let date: Double
    let main: Main
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
      case date = "dt"
      case main
      case weather
    }
  }
}


