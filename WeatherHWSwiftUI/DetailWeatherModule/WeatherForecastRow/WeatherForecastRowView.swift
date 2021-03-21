//
//  WeatherForecastRowView.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 18.03.2021.
//

import SwiftUI

struct WeatherForecastRowView: View {
    
    let viewModel: WeatherForecastRowViewModel
    
    var body: some View {
        HStack {
            date
            Spacer()
            temperature
        }
        .padding(20)
        .background(Color.init(.systemBlue))
        .foregroundColor(.white)
        .cornerRadius(15)
    }
    
    private var temperature: some View  {
        HStack{
            Text(viewModel.maxTemperature)
            Rectangle()
                .frame(width: 2, height: 15)
                .background(Color.white)
            
            Text(viewModel.minTemperature)
            
            viewModel.icon
        }
        
    }
    
    private var date: some View {
        HStack {
            Text(viewModel.day)
        }
        .font(.headline)
    }
    
}

struct WeatherForecastRowView_Previews: PreviewProvider {
 
    static var mainMock = Main(temperature: 20.4, feelsLike: 23,
                               humidity: 100, maxTemp: 30.3, minTemp: 23.4)
    
    static var forecastMock = WeatherForecast(from: DailyWeatherResponse.Item(date: 1616336256,
                                                                              main: mainMock,
                                                                              weather: [Weather(icon: "sun.max",
                                                                                                description: "very cold".firstUppercased)]))
    
    static var viewModelMock = WeatherForecastRowViewModel(forecast: forecastMock)
    
    static var previews: some View {
        WeatherForecastRowView(viewModel: viewModelMock)
    }
}
