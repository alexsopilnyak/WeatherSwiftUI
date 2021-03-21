//
//  CitiesWeatherViewModel.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 16.03.2021.
//

import Foundation
import Combine
import SwiftUI


class CitiesWeatherViewModel: ObservableObject {
    @Published var currentWeather: [CurrentWeather] = []
    
    let networkService: WeatherNetworkService
    var defaultCities = UserDefaults.standard.object(forKey: "cities") as? [String] ?? ["Kyiv", "Shpola"]
    
    private var subs = Set<AnyCancellable>()
    private let scheduler = DispatchQueue(label: "CurrentCityViewModel")
    
    init(networkService: WeatherNetworkService) {
        self.networkService = networkService
        
    }
    
    func fetchWeather(for city: String) {
        networkService.fetchCurrentWeather(for: city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure:
                    self.currentWeather = []
                case.finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.currentWeather.append(.init(value))
            })
            .store(in: &subs)
    }
    
    
    
}


extension CitiesWeatherViewModel {
    func loadDefaultsWeather() {
        defaultCities.sorted()
            .forEach{
            fetchWeather(for: $0)
        }
    }
    
    func add(_ city: String) {
        if !defaultCities
            .map({ $0.lowercased() })
            .contains(city.lowercased()) {
            
            defaultCities.append(city)
            
            UserDefaults.standard.setValue(defaultCities, forKey: "cities")
        }
        
        fetchWeather(for: city)
        
    }
}
