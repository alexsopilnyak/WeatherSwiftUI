//
//  ImageManager.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 19.03.2021.
//

import Foundation
import SwiftUI

struct ImageManager {
    
    static func icon(for imageName: String) -> Image {
        switch imageName {
        case "01d": return Image(systemName: "sun.max")
        case "01n": return Image(systemName: "moon")
        case "02d": return Image(systemName: "cloud.sun")
        case "02n": return Image(systemName: "cloud.moon")
        case "03d", "03n", "04d", "04n": return Image(systemName: "cloud")
        case "09d", "09n": return Image(systemName: "cloud.rain")
        case "10d": return Image(systemName: "cloud.sun.rain")
        case "10n": return Image(systemName: "cloud.moon.rain")
        case "11d", "11n": return Image(systemName: "cloud.bolt.rain")
        case "13d", "13n": return Image(systemName: "cloud.snow")
        case "50d", "50n": return Image(systemName: "cloud.fog")
        default: return Image(systemName: "sun.max")
        }
    }
}
