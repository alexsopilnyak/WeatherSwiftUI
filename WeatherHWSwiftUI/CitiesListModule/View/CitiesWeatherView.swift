//
//  ContentView.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 15.03.2021.
//

import SwiftUI

struct CitiesWeatherView: View {
    @ObservedObject var viewModel: CitiesWeatherViewModel
    @State private var alertPresented = false
    
    var body: some View {
        ZStack {
            citiesView
        }
        .alert(isPresented: $alertPresented, TextAlert(title: "Add New City") {
            guard let city = $0 else { return }
            viewModel.add(city)
        })
        .onAppear(perform: {
            viewModel.loadDefaultsWeather()
            }
           
        )
    }
}

private extension CitiesWeatherView {
    private var addCityButton: some View {
        Button("Add City") {
            alertPresented = true
        }
    }
    
    private var clearCitiesList: some View {
        Button("Clear") {
            viewModel.clearCitiesList()
        }
    }
    
    private var citiesView: some View {
        NavigationView {
            citiesTable
        }
    }
    
    private var citiesTable: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.currentWeather) { makeCityRow(with: $0) }
            }
            .padding()
        }
        .padding(.top)
        .navigationTitle("WeatherSUI🌧")
        .navigationBarItems(leading: clearCitiesList, trailing: addCityButton)
    }
    
    private func makeCityRow(with currentWeather: CurrentWeather) -> some View {
        let detailWeatherView = DetailWeatherView(cityName: currentWeather.city, currentWeather: currentWeather)
        let citiesListRowViewModel = CitiesListRowViewModel(currentWeather: currentWeather)
        
        return NavigationLink(destination: detailWeatherView) {
            CitiesListRowView(viewModel: citiesListRowViewModel)
        }
    }
    
    
    
}
