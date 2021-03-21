//
//  CitiesListRow.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 18.03.2021.
//

import SwiftUI

struct CitiesListRowView: View {
    var viewModel: CitiesListRowViewModel
    
    var body: some View {
        weatherRow
    }
    
    private var weatherRow: some View {
        HStack {
            viewModel.icon
            Text(viewModel.city)
            Spacer()
            Text("\(viewModel.temperature)")
        }
        .foregroundColor(.white)
        .font(.system(size: 30))
        .padding()
        .background(Color.blue)
        .cornerRadius(30)
    }
}
