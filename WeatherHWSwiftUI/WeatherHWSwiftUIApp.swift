//
//  WeatherHWSwiftUIApp.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 15.03.2021.
//

import SwiftUI

@main
struct WeatherHWSwiftUIApp: App {
 
    var body: some Scene {
      let networkService = WeatherNetworkService()
      let viewModel = CitiesWeatherViewModel(networkService: networkService)
        WindowGroup {
          CitiesWeatherView(viewModel: viewModel)
        }
    }
}
