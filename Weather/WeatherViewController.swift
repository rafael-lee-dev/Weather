//
//  WeatherViewController.swift
//  Weather
//
//  Created by Sousuke Tanaka on 11/1/17.
//  Copyright © 2017 Sousuke Tanaka. All rights reserved.
//

import UIKit
import MapKit
import ARSLineProgress
import AFNetworking

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelLat: UILabel!
    @IBOutlet weak var labelLon: UILabel!
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelPressure: UILabel!
    
    var coordinate: CLLocationCoordinate2D = kCLLocationCoordinate2DInvalid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.labelLat.text = "Latitude : \(self.coordinate.latitude)"
        self.labelLon.text = "Longitude : \(self.coordinate.longitude)"
        
        self.getWeatherInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeatherInfo() {
        ARSLineProgress.show()
        
        let manager = AFHTTPSessionManager()
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(self.coordinate.latitude)&lon=\(self.coordinate.longitude)&units=metric&appid=7e14924ee91f632b1119184cd7127011"
        print("url = \(url)")
        
        manager.get(url, parameters: nil, progress: nil, success: { (_, responseObject) in
            
            ARSLineProgress.hide()
            
            if let dict = responseObject as? [String: Any] {
                print(dict)
                self.updateWeatherInfo(dict: dict)
            }
            else {
                AppUtils.presentAlert(parent: self, title: "Error", message: "Invalid response")
            }
            
        }) { (_, error) in
            
            ARSLineProgress.hide()
            AppUtils.presentAlert(parent: self, title: "Error", message: error.localizedDescription)
        }
    }
    
    func updateWeatherInfo(dict:[String: Any]) {
        self.labelName.text = dict["name"] as? String
        self.labelWeather.text = (dict["weather"] as? [[String: Any]])?[0]["description"] as? String
        if let pressure = (dict["main"] as? [String: Any])?["pressure"] as? Float {
            self.labelPressure.text = "Pressure: \(pressure)"
        }
        if let temp = (dict["main"] as? [String: Any])?["temp"] as? Float {
            self.labelTemp.text = "Temperature: \(temp)"
        }
    }

}
