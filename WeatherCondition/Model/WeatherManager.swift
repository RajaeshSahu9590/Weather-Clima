//
//  WeatherManager.swift
//  WeatherCondition
//
//  Created by UTTAM on 11/02/21.
//  Copyright © 2021 UTTAM. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weatherManager: WeatherManager,weather: WeatherModel)
    
    func didUpdateWithFail(error: Error)
}
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=1d28bde6ecbad8af3c125a8d400d9808&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchData(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performanceRequest(urlString: urlString)
    }
    func fetchData(latitude: CLLocationDegrees,longitude: CLLocationDegrees){
       let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        performanceRequest(urlString: urlString)
    }
    
    func performanceRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, responce, error) in
                if error != nil{
                    self.delegate?.didUpdateWithFail(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseRequest(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weatherManager: self, weather: weather)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseRequest(weatherData: Data)-> WeatherModel?{
        let decoder = JSONDecoder()
        
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            
            let weather = WeatherModel(cityName: name, conditionId: id, temperature: temp)
            return weather
        } catch  {
            delegate?.didUpdateWithFail(error: error)
            return nil
            
        }
    }
}
