//
//  WeatherMainCollectionViewCell.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 01/09/18.
//  Copyright © 2018 Naga Murala. All rights reserved.
//

import UIKit
protocol FindWeatherDelegate {
    func getDesiredCityInformation(data city: String?)
}
class WeatherMainCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    //To see it's so ugly, but really we can refractor and maintain these outlets in their individual views.
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var controlLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var findWeather: UIButton!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherStatus: UILabel!
    @IBOutlet weak var temparature: UILabel!
    @IBOutlet weak var dayTempView: DayTemparatureView!
    @IBOutlet weak var dayName: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var bufferLine: UIView!
    @IBOutlet weak var degree: UILabel!
    var isContentViewHidden: Bool = true
    var findWeatherDelegate: FindWeatherDelegate?
    var data : WeatherInfoResponse?
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "theme")
        iv.image = image
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCollectionViewCell()
    }
    
    func configureCollectionViewCell(data: WeatherViewModel? = nil) {
        if textField != nil {
            textField.delegate = self
        }
        addGestureConfiguratios()
        self.data = data?.weatherInfoResponse
        setDataToView()
    }
    
    func setDataToView()  {
        if self.cityName != nil {
            if let cityName = data?.name {
                self.cityName.text = cityName
            }
        }
        if self.weatherStatus != nil {
            if let weather = data?.weather, weather.count > 0, let mainStatus = weather[0].main{
                self.weatherStatus.text = mainStatus
            }
        }
        if self.temparature != nil {
            if let temp = data?.main?.temp {
                self.temparature.text = getConvertedTemp(temp: temp)
                self.degree.isHidden = false
            }
        }
        if self.todayLabel != nil {
            todayLabel.text = "Today"
        }
        if self.dayName != nil {
            if let timeInterval = data?.dt {
                let date = Date(timeIntervalSince1970: timeInterval)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat  = "EEEE"//"EE" to get short style
                self.dayName.text = dateFormatter.string(from: date)//"Sunday"
                self.todayLabel.isHidden = false
            }
        }
        if self.minTemp != nil {
            if let temp = data?.main?.temp_min {
                self.minTemp.text = getConvertedTemp(temp: temp)
            }
        }
        if self.maxTemp != nil {
            if let temp = data?.main?.temp_max {
                self.maxTemp.text = getConvertedTemp(temp: temp)
                self.bufferLine.isHidden = false
            }
        }
        if self.weatherIcon != nil {
            if let vc = findWeatherDelegate as? WeatherViewController {
                if let image = vc.viewModel.weatherImage {
                    self.weatherIcon.image = image
                    self.weatherIcon.translatesAutoresizingMaskIntoConstraints = false
                    self.weatherIcon.tintColor = UIColor(white: 1, alpha: 0.4)
                }
                
            }
        }
    }
    
    func getConvertedTemp(temp: Double) -> String {
        let tempKelvin = temp
        let tempCelcius = Int(tempKelvin - 273.15)
        return "\(tempCelcius)"
    }
    
    func addGestureConfiguratios() {
        let tapGesture = UITapGestureRecognizer(target:self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGesture)
        if controlView != nil {
            self.findWeather.translatesAutoresizingMaskIntoConstraints = false
            self.findWeather.titleLabel?.text = "Find"
            controlView.backgroundColor = UIColor(white: 0.9, alpha: 0.2)
            controlView.layer.cornerRadius = self.controlView.frame.height / 2 - 5
            self.textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
            self.controlLabel.textColor = UIColor(white: 0.9, alpha: 1)
            self.findWeather.titleLabel?.textColor = UIColor(white: 0.9, alpha: 1)
            self.findWeather.backgroundColor = UIColor(white: 0.5, alpha: 1)
            self.findWeather.layer.cornerRadius = self.findWeather.frame.height / 2 - 5
            controlView.isHidden = true
            isContentViewHidden = true
        }
    }
    
    @IBAction func findWeatherButtonClicked(_ sender: Any) {
        guard let delegate = findWeatherDelegate else { return }
        guard let inputText = textField.text else { return }
        delegate.getDesiredCityInformation(data: inputText)
    }
    //All animation stuff we can maintain one ThemeAware class and keep it away from this class
    @objc func handleTapGesture() {
        if self.controlView != nil {
            if self.controlView.isHidden, isContentViewHidden {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.findWeather.isHidden = false
                    self.controlView.isHidden = false
                    self.isContentViewHidden = false
                    self.controlView.backgroundColor = UIColor(white: 0.9, alpha: 0.2)
                    self.textField.backgroundColor = UIColor(white: 0.9, alpha: 1)
                    self.controlLabel.textColor = UIColor(white: 0.9, alpha: 1)
                    self.findWeather.titleLabel?.textColor = UIColor(white: 0.9, alpha: 1)
                    self.findWeather.backgroundColor = UIColor(white: 0.5, alpha: 1)
                }) { (isanimationCompleted) in
                    //NOOP
                }
            }else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.findWeather.isHidden = true
                    self.findWeather.titleLabel?.textColor = UIColor(white: 0, alpha: 0)
                    self.controlView.backgroundColor = UIColor(white: 0, alpha: 0)
                    self.textField.backgroundColor = UIColor(white: 0, alpha: 0)
                    self.controlLabel.textColor = UIColor(white: 0, alpha: 0)
                    self.findWeather.backgroundColor = UIColor(white: 0, alpha: 0)
                }) { (isanimationCompleted) in
                    self.controlView.isHidden = true
                    self.isContentViewHidden = true
                    //TODO: Do so stuff after the animation
                }
            }
        }
        if textField.canResignFirstResponder{
            textField.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let delegate = findWeatherDelegate else { return true}
        guard let inputText = textField.text else { return true}
        delegate.getDesiredCityInformation(data: inputText)
        return true
    }
}
