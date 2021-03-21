//
//  EndPoint.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 16.03.2021.
//

import Foundation
import Combine

typealias Parameters = [String: Any]


protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var parameters: Parameters { get }
    var httpMethod: HTTPMethod { get }
}


enum APIEndpoint {
    case currentWeather(forCity: String)
    case weatherForecast(forCity: String)
}

extension APIEndpoint: Endpoint {
    
    var baseURL: URL {
        guard let url = URL(string: Config.baseURL) else {
            fatalError(WeatherError.network(decription: "Bad URL").localizedDescription)
        }
        return url
    }
    
    var path: String {
        switch self {
        case .currentWeather:
            return Config.weatherPath
        case .weatherForecast:
            return Config.forecastPath
        }
    }
    
    var parameters: Parameters {
        
        switch self {
        case .currentWeather(let city):
            var params = Config.defaultParameters
            params["q"] = city
            return params
        case .weatherForecast(let city):
            var params = Config.defaultParameters
            params["q"] = city
            return params
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
}


private enum Config {
    static let baseURL = "https://api.openweathermap.org/data/2.5"
    static let forecastPath = "/forecast"
    static let weatherPath = "/weather"
    static let appID = "484f8b6d115fcc214dd51aa8f37ea476"
    static let defaultParameters = ["mode": "json",
                                    "appid": Config.appID,
                                    "units": "metric"]
}

enum HTTPMethod: String {
    case get = "GET"
}
