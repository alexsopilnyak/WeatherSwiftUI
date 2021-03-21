//
//  CitiesListRowViewModel.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 18.03.2021.
//

import Foundation
import SwiftUI

class CitiesListRowViewModel: Identifiable {
    let currentWeather: CurrentWeather
    let id = UUID()
    
    init(currentWeather: CurrentWeather) {
        self.currentWeather = currentWeather
    }
    
    var temperature: String {
        String(format: "%.0fº", currentWeather.temperature)
    }
    
    var city: String {
        currentWeather.city
    }
    
    var icon: Image {
        currentWeather.icon
    }
    
}
