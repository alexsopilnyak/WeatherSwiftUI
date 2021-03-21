//
//  DetailWeatherViewModel.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 18.03.2021.
//

import Foundation
import Combine
import SwiftUI

class DetailWeatherViewModel: ObservableObject {
    @Published var detailForecast: DetailForecast?
    
    private let networkService = WeatherNetworkService()
    private var subs = Set<AnyCancellable>()
    
    func fetchDetailWeather(for city: String) {
        networkService.fetchWeatherForecast(for: city)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case.failure:
                    self.detailForecast = nil
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.detailForecast = .init(from: value)
                
            } )
            .store(in: &subs)
    }
    
    func dailyForecast() -> [WeatherForecast] {
        guard let dailyForecast = detailForecast?.forecast.uniques else {
            return [WeatherForecast]()
        }
        return dailyForecast
    }
}
