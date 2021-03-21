//
//  StringProtocol + Extension.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 21.03.2021.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
