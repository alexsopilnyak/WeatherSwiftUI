//
//  NetworkService.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 16.03.2021.
//

import Foundation
import Combine

protocol NetworkService {
    func fetchCurrentWeather(for city: String) -> AnyPublisher<CurrentWeatherResponse, WeatherError>
    func fetchWeatherForecast(for city: String) -> AnyPublisher<DailyWeatherResponse, WeatherError>
}

final class WeatherNetworkService: NetworkService {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchWeatherForecast(for city: String) -> AnyPublisher<DailyWeatherResponse, WeatherError> {
        let request = buildRequest(for: .weatherForecast(forCity: city))
        return fetch(with: request)
    }
    
    func fetchCurrentWeather(for city: String) -> AnyPublisher<CurrentWeatherResponse, WeatherError> {
        
        let request = buildRequest(for: .currentWeather(forCity: city))
        return fetch(with: request)
    }
    
    private func fetch<T: Codable>(with request: URLRequest) -> AnyPublisher<T, WeatherError> {
        return session.dataTaskPublisher(for: request)
            .mapError { error in
                .network(decription: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
}


private extension NetworkService {
    
    func buildRequest(for endpoint: APIEndpoint) -> URLRequest{
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
    
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod.rawValue
        
        self.configure(request: &request, with: endpoint.parameters)
        
        return request
    }
    
    func configure(request: inout URLRequest,with parameters: Parameters) {
        guard let url = request.url else { return }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty else { return }
        
        urlComponents.queryItems = [URLQueryItem]()
        
        parameters.forEach {
            let queryItem = URLQueryItem(name: $0, value: "\($1)".removingPercentEncoding)
            urlComponents.queryItems?.append(queryItem)
        }
        request.url = urlComponents.url
        
    }
}
