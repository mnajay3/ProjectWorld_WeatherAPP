//
//  ViewController.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 11/9/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import UIKit
import ProjectWorldFramework
/***
 //MVVM design Pattern
 Initial view controller follows MVVM design pattern by tightly coupling the ViewModel with View(ViewController).
 This Contoller performs only high level operatios include triggering the view model to fetch all the network information. Intern view model map the information to the model object
 ***/

class WeatherViewController: MasterViewController,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, FindWeatherDelegate {
    //Only the reason to have it as IBoutet is for tightly coupling the view(ViewController) with ViewModel
    //The second reason: Let interfacebuilder create the object for it 100% of the time, Since it's obvious that everytime invoke the ViewModel and eliminate nil objects on manual instantiations
    @IBOutlet var viewModel: WeatherViewModel!
    @IBOutlet weak var weatherMainCollectionView: UICollectionView!
    
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "theme")
        iv.image = image
        return iv
    }()
    let weatherInfoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("WeatherInformation", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(white: 0.6, alpha: 0.6)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    
    let userInfoText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = USER_INFO_TEXT
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        label.numberOfLines = 2
        return label
    }()
    
    //Making sure not to create the object until it's first time use..
    lazy var activityIndicator: UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        ac.translatesAutoresizingMaskIntoConstraints = false
        return ac
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageName = "WeatherMainViewController"
        self.segueAlias = "weatherDetails"
        setCollectionViewConfigurations()
        
        self.view.addSubview(activityIndicator)
        self.view.addSubview(weatherInfoButton)
        self.view.addSubview(userInfoText)
        addConstraints()
        self.perform(#selector(handleUserInfoText), with: self, afterDelay: 3.0)
    }
    func addConstraints() {
        self.view.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: userInfoText, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: userInfoText, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 15))
        
        self.weatherInfoButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.weatherInfoButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.weatherInfoButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.weatherInfoButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    //MARK:- Objective-C functions Interfacebuilder Button EventHandler
    @objc func handleButton() {
        //Page navigation and page presentations are completely handling by ProjectWorldFrameWork
        self.initializeSceneConfig(bundle: nil)
        self.presentScene(bundle: nil)
    }
    @objc func handleUserInfoText() {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.userInfoText.isHidden = true
        }, completion: nil)
    }
    
    //MARK:- DeviceTransition methods
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        UIApplication.shared.statusBarView?.isHidden = true
    }
    
    //MARK:- AssinDelegates
    func setCollectionViewConfigurations() {
        self.weatherMainCollectionView.delegate = self
        self.weatherMainCollectionView.dataSource = self
        weatherMainCollectionView = {
            self.weatherMainCollectionView.delegate = self
            self.weatherMainCollectionView.backgroundView = imageView
            self.weatherMainCollectionView.showsVerticalScrollIndicator = false
            return weatherMainCollectionView
        }()
    }
    
    //MARK:-ViewModelInvoker
    //Invoke ViewModel to call service and fetch weather report
    private func fetchWeatherReport(input inputCity: String) {
        // This method calls eventually invokes the service and fetch the wether information for provided city info.
        //In Breif, This method call trigger the view modal method for further process.
        self.activityIndicator.startAnimating()
        viewModel.getWeatherInfo(city: inputCity) { [unowned self] in
            self.weatherMainCollectionView.reloadData()
            self.activityIndicator.stopAnimating()
            //Service Call to get the image
            self.viewModel.getWeatherImage { [unowned self] in
//                self.viewModel.setDataIntoUserDefaults()
                self.weatherMainCollectionView.reloadData()
            }
            
        }
    }
    
    //MARK:- CollectionView Datasource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let _cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherMainCollectionViewCell
//        _cell.backgroundColor = .blue
        _cell.findWeatherDelegate = self
        _cell.configureCollectionViewCell(data: viewModel.weatherInfoResponse)
        return _cell
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.weatherMainCollectionView.frame.height)
    }
    
    func getDesiredCityInformation(data city: String?) {
        guard let city = city else { return }
        fetchWeatherReport(input: city)
    }
    
}

