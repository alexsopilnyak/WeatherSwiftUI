//
//  WeatherForecastRowViewModel.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 18.03.2021.
//

import Foundation
import Combine
import SwiftUI


class WeatherForecastRowViewModel {
  
  let forecast: WeatherForecast
  
  init(forecast: WeatherForecast) {
    self.forecast = forecast
  }
  
  var day: String {
    forecast.dateString
  }
  
  var maxTemperature: String {
    String(format: "%.0fº", forecast.maxTemp)
  }
  
  var minTemperature: String  {
    String(format: "%.0fº", forecast.minTemp)
  }
  
  var icon: Image {
    forecast.icon
  }
  
  
}

