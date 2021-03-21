//
//  WeatherError.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 16.03.2021.
//

import Foundation

enum WeatherError: Error {
  case parsing(decription: String)
  case network(decription: String)
}
