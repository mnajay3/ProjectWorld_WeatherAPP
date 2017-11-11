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
        self.view.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        UIApplication.shared.statusBarView?.isHidden = true
    }
    
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.weatherMainCollectionView.frame.height)
    }
    
    func getDesiredCityInformation(data city: String?) {
        guard let city = city else { return }
        fetchWeatherReport(input: city)
    }
    
}

