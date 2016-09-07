//
//  Weather.swift
//  WeatherApp
//
//  Created by Aaron Chambers on 2016-09-04.
//  Copyright © 2016 AaronChambers. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class Weather{
    
    private var _cityName: String!
//    private var _weatherImage: UIImage!
    private var _temp: Double!
    private var _weatherType: String!
    private var _humidity: String!
    private var _airPressure: String!
    private var _minTemp: Double!
    private var _maxTemp: Double!
    private var _sunriseTime: String!
    private var _sunsetTime: String!
    private var _windSpeed: String!
    private var _latUrl: String!
    private var _longUrl: String!
    

    var cityName: String{
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    
//    var weatherImage: UIImage{
//        if _weatherImage == nil{
//            
//        }
//        return _weatherImage
//    }
    var weatherTemp: Double{
        if _temp == nil{
            _temp = 0
            
        }
        return _temp
    }
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
            
        }
        return _weatherType
    }
    var humidity: String{
        if _humidity == nil{
            _humidity = ""
            
        }
        return _humidity
    }
    var airPressure: String{
        if _airPressure == nil{
            _airPressure = ""
            
        }
        return _airPressure
    }
    var minTemp: Double{
        if _minTemp == nil{
            _minTemp = 0
            
        }
        return _minTemp
    }
    var maxTemp: Double{
        if _maxTemp == nil{
            _maxTemp = 0
            
        }
        return _maxTemp
    }
    var sunriseTime: String{
        if _sunriseTime == nil{
            _sunriseTime = ""
            
        }
        return _sunriseTime
    }
    var sunsetTime: String{
        if _sunsetTime == nil{
            _sunsetTime = ""
            
        }
        return _sunsetTime
    }
    var windSpeed: String{
        if _windSpeed == nil{
            _windSpeed = ""
            
        }
        return _windSpeed
    }
    
    var latUrl: String{
        
        return _latUrl
    }
    var longUrl: String{
        return _longUrl
    }
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        _latUrl =  "\(latitude)"
        _longUrl = "\(longitude)"
    }

    
    
    
    func downloadWeather(completion: DownloadComplete){
        let lat = _latUrl
        let long = _longUrl
        
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=fc0ce02b3f3c74c2d96d2b4ee53c0060"
        print(url)
        
        Alamofire.request(.GET,url ).responseJSON { response in
            let getResponse = response.result
            if let dict = getResponse.value as? Dictionary<String, AnyObject>{
                if let city = dict["name"]{
                    self._cityName = "\(city)"
                    print(self.cityName)
                }
                if let weatherDesc = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    if let wType = weatherDesc[0]["description"] as? String{
                        self._weatherType = "\(wType.capitalizedString)"
                        print(self.weatherType)
                    }
                }
                if let mainDesc = dict["main"] as? Dictionary<String,AnyObject>{
                    if let mainTemp = mainDesc["temp"] as? Double{
                        let temp = mainTemp - 273.15
                        self._temp = temp
                        print(self.weatherTemp)
                    }
                    if let pressure = mainDesc["pressure"]{
                        self._airPressure = "\(pressure)"
                        print(self.airPressure)
                    }
                    if let humidity = mainDesc["humidity"]{
                        self._humidity = "\(humidity)"
                        print(self.humidity)
                    }
                    if let minTemp = mainDesc["temp_min"] as? Double{
                        let temp = minTemp - 273.15
                        self._minTemp = (temp)
                        print(self.minTemp)
                    }
                    if let maxTemp = mainDesc["temp_max"] as? Double{
                        let temp = maxTemp - 273.15
                        self._maxTemp = temp
                        print(self.maxTemp)
                    }
                }
                if let windDesc = dict["wind"] as? Dictionary<String,AnyObject>{
                    if let wSpeed = windDesc["speed"]{
                        self._windSpeed = "\(wSpeed)"
                        print(self.windSpeed)
                    }
                }
                if let sys = dict["sys"] as? Dictionary<String, AnyObject>{
                    if let sunrise = sys["sunrise"] as? Double{
                        let time = NSDate(timeIntervalSince1970: sunrise)
                        var formatTime = "\(time)"
                        let range = formatTime.startIndex.advancedBy(0)..<formatTime.startIndex.advancedBy(11)
                        formatTime.removeRange(range)
                        var newStr = formatTime.stringByReplacingOccurrencesOfString("+0000", withString: "")
                        let subrange = newStr.startIndex.advancedBy(5)..<newStr.startIndex.advancedBy(8)
                        newStr.removeRange(subrange)
                        self._sunriseTime = "\(newStr)"
                        print(self.sunriseTime)
                    }
                    if let sunset = sys["sunset"] as? Double{
                        let time = NSDate(timeIntervalSince1970: sunset)
                        var formatTime = "\(time)"
                        let range = formatTime.startIndex.advancedBy(0)..<formatTime.startIndex.advancedBy(11)
                        formatTime.removeRange(range)
                        var newStr = formatTime.stringByReplacingOccurrencesOfString("+0000", withString: "")
                        let subrange = newStr.startIndex.advancedBy(5)..<newStr.startIndex.advancedBy(8)
                        newStr.removeRange(subrange)
                        self._sunsetTime = "\(newStr)"
                        print(self.sunsetTime)
                    }
                }
                completion()
            }
        }
    }
}