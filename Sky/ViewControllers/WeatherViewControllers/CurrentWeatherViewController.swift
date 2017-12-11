//
//  CurrentWeatherViewController.swift
//  Sky
//
//  Created by roni on 2017/12/11.
//  Copyright © 2017年 Mars. All rights reserved.
//

import UIKit

protocol CurrentWeatherViewControllerDelegate: class {
    func locationButtonPressed(
        controller: CurrentWeatherViewController)
    func settingsButtonPressed(
        controller: CurrentWeatherViewController)
}

class CurrentWeatherViewController: WeatherViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        delegate?.locationButtonPressed(controller: self)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        delegate?.settingsButtonPressed(controller: self)
    }
    
//    var now: WeatherData? {
//        didSet {
//            DispatchQueue.main.async { self.updateView() }
//        }
//    }
//    var location: Location? {
//        didSet {
//            DispatchQueue.main.async { self.updateView() }
//        }
//    }
    
    var viewModel: CurrentWeatherViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    weak var delegate: CurrentWeatherViewControllerDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateView() {
//        activityIndicatorView.stopAnimating()
//
//        if let now = now, let location = location {
//            updateWeatherContainer(with: now, at: location)
//        }
//        else {
//            loadingFailedLabel.isHidden = false
//            loadingFailedLabel.text =
//            "Cannot load fetch weather/location data from the network."
//        }
        
        if let vm = viewModel, vm.isUpdateReady {
            updateWeatherContainer(with: vm)
        }
        else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "Load weather/location failed."
        }
    }

    func updateWeatherContainer(with vm: CurrentWeatherViewModel) {
        weatherContainerView.isHidden = false
        
        locationLabel.text = vm.city
        temperatureLabel.text = vm.temperature
        weatherIcon.image = vm.weatherIcon
        humidityLabel.text = vm.humidity
        summaryLabel.text = vm.summary
        dateLabel.text = vm.date
    }
//    func updateWeatherContainer(with data: WeatherData, at location: Location) {
//        weatherContainerView.isHidden = false
//
//        // 1. Set location
//        locationLabel.text = location.name
//
//        // 2. Format and set temperature
//        temperatureLabel.text = String(
//            format: "%.1f °C",
//            data.currently.temperature.toCelcius())
//
//        // 3. Set weather icon
//        weatherIcon.image = weatherIcon(
//            of: data.currently.icon)
//
//        // 4. Format and set humidity
//        humidityLabel.text = String(
//            format: "%.1f %%",
//            data.currently.humidity*100)
//
//        // 5. Set weather summary
//        summaryLabel.text = data.currently.summary
//
//        // 6. Format and set datetime
//        let formatter = DateFormatter()
//        formatter.dateFormat = "E, dd MMMM"
//        dateLabel.text = formatter.string(
//            from: data.currently.time)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
