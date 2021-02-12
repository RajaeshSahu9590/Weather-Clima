//
//  WeatherData.swift
//  WeatherCondition
//
//  Created by UTTAM on 11/02/21.
//  Copyright © 2021 UTTAM. All rights reserved.
//

import Foundation
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Main: Codable {
    let temp: Double
}
struct Weather: Codable{
    let description: String
    let id: Int
}
