//
//  WeatherModel.swift
//  WeatherCondition
//
//  Created by UTTAM on 11/02/21.
//  Copyright © 2021 UTTAM. All rights reserved.
//

import Foundation
struct WeatherModel{
    var cityName: String
    var conditionId: Int
    var temperature: Double
    
    var temparetureString: String{
        return String(format: "%.f", temperature)
    }
    var conditionName: String{
        switch conditionId {
        case 200...232:
                   return "cloud.bolt"
               case 300...321:
                   return "cloud.drizzle"
               case 500...531:
                   return "cloud.rain"
               case 600...622:
                   return "cloud.snow"
               case 701...781:
                   return "cloud.fog"
               case 800:
                   return "sun.max"
               case 801...804:
                   return "cloud.bolt"
               default:
                   return "cloud"
        }
    }
    
    
}
