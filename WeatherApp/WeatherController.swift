//
//  ViewController.swift
//  WeatherApp
//
//  Created by Aaron Chambers on 2016-09-03.
//  Copyright © 2016 AaronChambers. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherController: UIViewController, CLLocationManagerDelegate {
    
    var locManager: CLLocationManager!
    var weather: Weather!
    
    let bgImg: UIImageView = {
        let bg = UIImageView()
        bg.contentMode = .ScaleAspectFill
        bg.image = UIImage(named: "Bg")
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    let locationLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Pickering"
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .Center
        lbl.textColor = .whiteColor()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }()
    let placeDivider: UIView = {
        let dv = UIView()
        dv.backgroundColor = UIColor.whiteColor()
        dv.alpha = 0.2
        dv.translatesAutoresizingMaskIntoConstraints = false
        return dv
    }()
    
    let weatherImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"Sunny")
        image.alpha = 0.8
        image.translatesAutoresizingMaskIntoConstraints = false
        
        image.contentMode = .ScaleAspectFill
        return image
    }()
    
    let weatherLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Sunny"
        lbl.adjustsFontSizeToFitWidth = false
        lbl.font = UIFont.boldSystemFontOfSize(35)
        lbl.textAlignment = .Center
        lbl.textColor = UIColor.whiteColor()
        lbl.alpha = 0.8
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let tempLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.whiteColor()
        lbl.alpha = 0.8
        lbl.font = UIFont.boldSystemFontOfSize(40)
        lbl.text = "26℃"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .Center
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    let divView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.02
        return view
    }()
    
    let humidityLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        lbl.text = "Humidity: 86%"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 1
        lbl.textAlignment = .Center
        lbl.font = UIFont.systemFontOfSize(20)
        
        return lbl
    }()
    
    let minTempLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        lbl.text = "Min: 10℃"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .Center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 1
        lbl.font = UIFont.systemFontOfSize(20)
        
        return lbl
    }()
    let maxTempLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        lbl.text = "Max: 30℃"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 1
        lbl.textAlignment = .Center
        lbl.font = UIFont.systemFontOfSize(20)
        
        return lbl
    }()
    let sunriseLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        lbl.text = "Sunrise: 6:30 AM"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 1
        lbl.textAlignment = .Center
        lbl.font = UIFont.systemFontOfSize(20)
        
        return lbl
    }()
    let sunsetLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        lbl.text = "Sunset: 9:45 PM"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 1
        lbl.textAlignment = .Center
        lbl.font = UIFont.systemFontOfSize(20)
        
        return lbl
    }()
    let windSpeed: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        lbl.text = "Wind Speed: 20 M/S"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 1
        lbl.textAlignment = .Center
        lbl.font = UIFont.systemFontOfSize(20)
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locManager.startUpdatingLocation()
        }
            }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        lat = locValue.latitude
        long = locValue.longitude
        
        weather = Weather(latitude: lat, longitude: long)
        weather.downloadWeather {
            self.setViews()
            self.setLabels()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
       
        
    }

    func setViews(){
        view.addSubview(bgImg)
        view.addSubview(locationLabel)
        view.addSubview(tempLabel)
        view.addSubview(weatherLabel)
        view.addSubview(weatherImage)
        view.addSubview(divView)
        view.addSubview(humidityLabel)
        view.addSubview(minTempLabel)
        view.addSubview(maxTempLabel)
        view.addSubview(sunriseLabel)
        view.addSubview(sunsetLabel)
        view.addSubview(windSpeed)
        
        bgImg.heightAnchor.constraintEqualToAnchor(view.heightAnchor).active = true
        bgImg.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        bgImg.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        bgImg.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        locationLabel.topAnchor.constraintEqualToAnchor(view.topAnchor,constant:10).active = true
        locationLabel.heightAnchor.constraintEqualToConstant(75).active = true
        locationLabel.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        weatherImage.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        weatherImage.bottomAnchor.constraintEqualToAnchor(view.centerYAnchor,constant: 10).active = true
        weatherImage.widthAnchor.constraintEqualToConstant(200).active = true
        weatherImage.heightAnchor.constraintEqualToConstant(200).active = true
        weatherLabel.widthAnchor.constraintEqualToAnchor(weatherImage.widthAnchor).active = true
        weatherLabel.heightAnchor.constraintEqualToConstant(44).active = true
        weatherLabel.topAnchor.constraintEqualToAnchor(weatherImage.bottomAnchor).active = true
        weatherLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        tempLabel.widthAnchor.constraintEqualToAnchor(weatherLabel.widthAnchor).active = true
        tempLabel.heightAnchor.constraintEqualToConstant(50).active = true
        tempLabel.topAnchor.constraintEqualToAnchor(weatherLabel.bottomAnchor).active = true
        tempLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        divView.topAnchor.constraintEqualToAnchor(tempLabel.bottomAnchor, constant: 5).active = true
        divView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        divView.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        divView.heightAnchor.constraintEqualToConstant(10).active = true
        humidityLabel.topAnchor.constraintEqualToAnchor(divView.bottomAnchor, constant: 5).active = true
        humidityLabel.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        humidityLabel.widthAnchor.constraintEqualToAnchor(view.widthAnchor).active = true
        humidityLabel.heightAnchor.constraintEqualToConstant(30).active = true
        minTempLabel.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 8).active = true
        minTempLabel.topAnchor.constraintEqualToAnchor(humidityLabel.bottomAnchor, constant: 5).active = true
        minTempLabel.heightAnchor.constraintEqualToAnchor(humidityLabel.heightAnchor).active = true
        minTempLabel.widthAnchor.constraintEqualToAnchor(view.widthAnchor, multiplier: 4.5/10).active = true
        maxTempLabel.leftAnchor.constraintEqualToAnchor(minTempLabel.leftAnchor).active = true
        maxTempLabel.topAnchor.constraintEqualToAnchor(minTempLabel.bottomAnchor, constant: 12).active = true
        maxTempLabel.widthAnchor.constraintEqualToAnchor(minTempLabel.widthAnchor).active = true
        maxTempLabel.heightAnchor.constraintEqualToAnchor(minTempLabel.heightAnchor).active = true
        sunriseLabel.topAnchor.constraintEqualToAnchor(humidityLabel.bottomAnchor, constant: 5).active = true
        sunriseLabel.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -8).active = true
        sunriseLabel.heightAnchor.constraintEqualToAnchor(minTempLabel.heightAnchor).active = true
        sunriseLabel.widthAnchor.constraintEqualToAnchor(minTempLabel.widthAnchor).active = true
        sunsetLabel.topAnchor.constraintEqualToAnchor(maxTempLabel.topAnchor).active = true
        sunsetLabel.rightAnchor.constraintEqualToAnchor(sunriseLabel.rightAnchor).active = true
        sunsetLabel.heightAnchor.constraintEqualToAnchor(sunriseLabel.heightAnchor).active = true
        sunsetLabel.widthAnchor.constraintEqualToAnchor(maxTempLabel.widthAnchor).active = true
        windSpeed.widthAnchor.constraintEqualToAnchor(humidityLabel.widthAnchor).active = true
        windSpeed.topAnchor.constraintEqualToAnchor(sunsetLabel.bottomAnchor, constant: 10).active = true
        windSpeed.heightAnchor.constraintEqualToAnchor(humidityLabel.heightAnchor).active = true
        windSpeed.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
    }
    
    func setLabels(){
        locationLabel.text = weather.cityName
        weatherLabel.text =  weather.weatherType
        tempLabel.text = "\(weather.weatherTemp)℃"
        humidityLabel.text = "Humidity: \(weather.humidity)%"
        minTempLabel.text = "Min: \(weather.minTemp)℃"
        maxTempLabel.text = "Max: \(weather.maxTemp)℃"
        windSpeed.text = "Wind Speed: \(weather.windSpeed) M/S"
        sunriseLabel.text = "Sunrise:\(weather.sunriseTime) AM"
        sunsetLabel.text = "Sunset: \(weather.sunsetTime) PM"
    }

}

    