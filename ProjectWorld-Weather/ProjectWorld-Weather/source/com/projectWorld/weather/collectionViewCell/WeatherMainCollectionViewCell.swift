//
//  WeatherMainCollectionViewCell.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 11/9/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
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
    //To persist user's last saved search
    lazy var persistLastSearch: UserDefaults = UserDefaults.standard
    var isContentViewHidden: Bool = true
    var findWeatherDelegate: FindWeatherDelegate?
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
    
    
    func configureCollectionViewCell(data: WeatherInfoResponse? = nil) {
        if textField != nil {
            textField.delegate = self
        }
        addGestureConfiguratios()
        setDataToView(data)
    }
    
    func setDataToView(_ data: WeatherInfoResponse?)  {
        if self.cityName != nil {
            if let cityName = data?.name {
                self.cityName.text = cityName
                persistLastSearch.set(cityName, forKey: CITY_NAME)
            } else if let cityName = persistLastSearch.value(forKey: CITY_NAME) {
                self.cityName.text = cityName as? String ?? ""
            }
        }
        if self.weatherStatus != nil {
            if let weather = data?.weather, weather.count > 0, let mainStatus = weather[0].main{
                self.weatherStatus.text = mainStatus
                persistLastSearch.set(mainStatus, forKey: "weather")
            } else if let weather = persistLastSearch.value(forKey: "weather") {
                self.weatherStatus.text = weather as? String ?? ""
            }
        }
        if self.temparature != nil {
            if let temp = data?.main?.temp {
                self.temparature.text = getConvertedTemp(temp: temp)
                self.degree.isHidden = false
                persistLastSearch.set(temp, forKey: "temp")
            } else if let temp = persistLastSearch.value(forKey: "temp") {
                if let temp = temp as? NSNumber {
                    self.temparature.text = getConvertedTemp(temp: temp)
                    self.degree.isHidden = false
                }
                
            }
        }
        if self.todayLabel != nil {
            todayLabel.text = "Today"
        }
        if self.dayName != nil {
            if let weekDayName = data?.weekDayName {
                self.todayLabel.isHidden = false
                self.dayName.text = weekDayName
                persistLastSearch.set(weekDayName, forKey: "weekDayName")
            } else if let weekDayName = persistLastSearch.value(forKey: "weekDayName") {
                self.dayName.text = weekDayName as? String ?? ""
                self.todayLabel.isHidden = false
            }
        }
        if self.minTemp != nil {
            if let temp = data?.main?.temp_min {
                self.minTemp.text = getConvertedTemp(temp: temp)
                persistLastSearch.set(temp, forKey: "temp_min")
            } else if let temp = persistLastSearch.value(forKey: "temp_min") {
                if let temp = temp as? NSNumber {
                    self.minTemp.text = getConvertedTemp(temp: temp)
                }
            }
        }
        if self.maxTemp != nil {
            if let temp = data?.main?.temp_max {
                self.maxTemp.text = getConvertedTemp(temp: temp)
                persistLastSearch.set(temp, forKey: "temp_max")
                self.bufferLine.isHidden = false
            } else if let temp = persistLastSearch.value(forKey: "temp_max") {
                if let temp = temp as? NSNumber {
                    self.maxTemp.text = getConvertedTemp(temp: temp)
                    self.bufferLine.isHidden = false
                }
            }
        }
        if self.weatherIcon != nil {
            if let image = data?.imageIcon {
                self.weatherIcon.image = image
                self.weatherIcon.translatesAutoresizingMaskIntoConstraints = false
                self.weatherIcon.tintColor = UIColor(white: 1, alpha: 0.4)
                ///               While it is possible to save a UIImage to NSUserDefaults, it is often not recommended as it is not        the most efficient way to save images; a more efficient way is to save your image in the application's Documents Directory
                ///
                persistLastSearch.set(UIImagePNGRepresentation(image), forKey: "imageIcon")
            }else if let imageData = persistLastSearch.object(forKey: "imageIcon") ,
                let image = UIImage(data: imageData as! Data){
                self.weatherIcon.image = image
                self.weatherIcon.translatesAutoresizingMaskIntoConstraints = false
                self.weatherIcon.tintColor = UIColor(white: 1, alpha: 0.4)
            }
        }
    }
    
    func getConvertedTemp(temp: NSNumber) -> String {
        let tempKelvin = Double(truncating: temp)
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
