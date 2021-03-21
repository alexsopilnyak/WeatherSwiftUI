//
//  DetailWeatherViewModel.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 18.03.2021.
//

import SwiftUI


struct DetailWeatherView: View {
    @ObservedObject var viewModel: DetailWeatherViewModel
    
    var currentWeather: CurrentWeather
    let cityName: String
    
    init(cityName: String, currentWeather: CurrentWeather) {
        self.cityName = cityName
        self.currentWeather = currentWeather
        self.viewModel = .init()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            descriptionTitle
            tempTitle
            feelsLikeTitle
            weatherDetails
            dailyForecast
            Spacer()
        }
        .onAppear(perform: {
            viewModel.fetchDetailWeather(for: cityName)
        })
        .padding(.top)
        .navigationTitle(cityName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

private extension DetailWeatherView {
    var feelsLikeTitle: some View {
        HStack {
            Text("Feels like")
            Text(String(format: "%.0fº", currentWeather.feelsLike))
        }
        .font(.headline)
        .foregroundColor(.gray)
    }
    
    var descriptionTitle: some View {
        Text(currentWeather.description.firstCapitalized)
            .font(.title2)
            .bold()
    }
    
    var tempTitle: some View {
        HStack {
            currentWeather.icon
            Text(String(format: "%.0fº", currentWeather.feelsLike))
            
        }
        .padding()
        .font(.system(size: 60))
        .foregroundColor(.blue)
    }
    
    var weatherDetails: some View {
        HStack(spacing: 20) {
            Spacer()
            detailsItem(image: .init(systemName: "wind"), text: "\(currentWeather.windSpeed) km/s")
            detailsItem(image: .init(systemName: "thermometer.sun"), text: "\(currentWeather.humidity) %")
            detailsItem(image: .init(systemName: "arrow.down.right.circle"), text: currentWeather.windDirection)
            Spacer()
        }
        .padding()
        .border(Color.init(.systemBlue))
    }
    
    func detailsItem(image: Image, text: String) -> some View {
        HStack {
            image
                .imageScale(.large)
                .foregroundColor(.blue)
            Text(text)
            
        }
    }
    
    var dailyForecast: some View {
        List {
            ForEach(viewModel.dailyForecast()) {
                WeatherForecastRowView(viewModel: WeatherForecastRowViewModel(forecast: $0))
            }
        }
    }
}
