//
//  ViewController.swift
//  WeatherCondition
//
//  Created by UTTAM on 10/02/21.
//  Copyright © 2021 UTTAM. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,WeatherManagerDelegate,UITextFieldDelegate, CLLocationManagerDelegate {
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var temparetureLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         locationManager.delegate = self
               locationManager.requestWhenInUseAuthorization()
                 locationManager.requestLocation()
                weatherManager.delegate = self
                searchTextField.delegate = self
       
        
        
    }

    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }
    
    //Mark - TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else {
            textField.placeholder = "Type Anything"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManager.fetchData(cityName: city)
        }
        searchTextField.text = ""
    }
    // Mark - WeatherManagerDelegate
    func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.nameLabel.text = String(weather.cityName)
            self.temparetureLabel.text = weather.temparetureString
            self.image.image = UIImage(systemName: weather.conditionName)
            
        }
       }
       
       func didUpdateWithFail(error: Error) {
           print(error)
       }
    //MARK: - Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            
            weatherManager.fetchData(latitude: lat, longitude: long)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
       
}

