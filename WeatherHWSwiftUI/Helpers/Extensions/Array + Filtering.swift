//
//  Array + Filtering.swift
//  WeatherHWSwiftUI
//
//  Created by Alexandr Sopilnyak on 19.03.2021.
//

import Foundation

///https://stackoverflow.com/a/46354989/491239
extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
