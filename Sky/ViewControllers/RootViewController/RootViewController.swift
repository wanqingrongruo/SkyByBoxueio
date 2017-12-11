//
//  ViewController.swift
//  Sky
//
//  Created by Mars on 28/09/2017.
//  Copyright © 2017 Mars. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        
        return manager
    }()
    private var currentLocation: CLLocation?{
        didSet {
            // Fetch the city name
            // Fetch the weather data
            fetchCity()
            fetchWeather()
        }
    }
    
    var currentWeatherViewController: CurrentWeatherViewController!
    var weekWeatherViewController: WeekWeatherViewController!
    private let segueCurrentWeather = "SegueCurrentWeather"
    private let segueWeekWeather = "SegueWeekWeather"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupActiveNotification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case segueCurrentWeather:
            guard let destination = segue.destination as? CurrentWeatherViewController else {
                fatalError("Invalid destination view controller!")
            }
            
            destination.delegate = self
            destination.viewModel = CurrentWeatherViewModel()
            currentWeatherViewController = destination
        case segueWeekWeather:
            guard let destination =
                segue.destination as? WeekWeatherViewController else {
                    fatalError("Invalid destination view controller.")
            }
            
            weekWeatherViewController = destination
        default:
            break
        }
    }
    
}

//MARK: - private methods
extension RootViewController {
    
    private func setupActiveNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(RootViewController.applicationDidBecomeActive(notification:)), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    @objc func applicationDidBecomeActive(notification: Notification) {
        requestLocation()
    }
    
    // 请求位置
    private func requestLocation() {
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func fetchCity() {
        guard let currentLocation = currentLocation else { return }
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) { placemarks, error in
            if let error = error {
                dump(error)
            } else if let city = placemarks?.first?.locality {
                // Todo: Notify CurrentWeatherViewController
//                self.currentWeatherViewController.location = Location(
//                    name: city,
//                    latitude: currentLocation.coordinate.latitude,
//                    longitude: currentLocation.coordinate.longitude)
                let location = Location(name: city, latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
                self.currentWeatherViewController.viewModel?.location = location
            }
        }
    }
    
    private func fetchWeather() {
        guard let currentLocation = currentLocation else { return }
        
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        
        WeatherDataManager.shared.weatherDataAt(latitude: lat, longitude: lon, completion: { response, error in
                if let error = error {
                    dump(error)
                }
                else if let response = response {
                    // Todo: Notify CurrentWeatherViewController
                   // self.currentWeatherViewController.now = response
                    self.currentWeatherViewController.viewModel?.weather = response
                    self.weekWeatherViewController.viewModel =
                        WeekWeatherViewModel(weatherData: response.daily.data)
                }
        })
    }
}

extension RootViewController: CurrentWeatherViewControllerDelegate {
    func locationButtonPressed(controller: CurrentWeatherViewController) {
        print("Open locations.")
    }
    
    func settingsButtonPressed(controller: CurrentWeatherViewController) {
        print("Open Settings")
    }
}

extension RootViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            manager.delegate = nil
            
            manager.stopUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error)
    }
}
