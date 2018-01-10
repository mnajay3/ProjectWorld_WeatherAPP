//
//  ViewController.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 01/09/18.
//  Copyright © 2018 Naga Murala. All rights reserved.
//

import UIKit
import ProjectWorldFramework
/***
 //MVVM design Pattern
 Initial view controller follows MVVM DESIGN PATTERN by tightly coupling the ViewModel with View(ViewController).
 This Contoller performs only high level operatios include triggering the view model to fetch all the network information. Intern view model map the information to the model object
 ***/

/****
            :) Just as a first Note: Please tap on the screen to Enter the city Name.
 
 //TODO:
 I want evenmore refractoring my view controller(view) by using delegation design patter. Even we are following MVVM design pattern to reduce the burdern on controller from actual business logic, I would keep all collectionView delegate and datasource methods out side of this controller by following Delegation design patter inside MVVM.
     For the referance of my thought: I have already done it for table view delegates and datasource in my ProjectWorld frame work( I included under collectionView and collectionViewCell group in ProjectWorldFrameWork api.
     I would follow the same way for collection view behaviour so that we can reduce the burder even more from this view(viewcontroller)
 
 //TODO:
 ViewModal is taking care of all the business logic. Either view controller or table view cell(view) doesn't any thing about what's happening inside. let's say for instance
 Weather api won't get called every time member clicks on find button with same city.. We have a control in view modal where it check's the time interval between previous search and current search.. if it exceeds 4 hours with the same city then call api other wise fetch it from the previous returned object where we store it in userdefaults.
 
 
 //TODO:
 I would change the collectionView pattern. Main thin is about Collectionview cell. I am feeling it's so clumsy. I would use all cusom views(classes) for each group of UIattributes. All string literal I would rather declare it in constants file so that the could will be very clean and interactive.
 
 //TODO:
 I am trying to use Interface builder features Autoconstraints, StackViews and size classes along with Custom UI objects and custom constraints through program. I agree, It's bit easy to add the constraints through Interface builder but adding custom attributes and constraints improves our technical ability and brush up our skills in all the aspects
 
 //TODO:
 TESTCASES: I have included the service test cases but Still there is a huge space of implementing the testcases. I would more concentrate on XCUITESTCASE to automate my project. It's obvious to implemtn UI automate test framework
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
        //Making sure to set the page Name and SegueAlias name, so that the page navigatio will be taken care by my ProjectWorldFrameWork api
        self.pageName = "WeatherMainViewController"
        self.segueAlias = "weatherDetails"
        setCollectionViewConfigurations()
        self.view.addSubview(activityIndicator)
        self.view.addSubview(weatherInfoButton)
        self.view.addSubview(userInfoText)
        addConstraints()
        //Setting the find city textbox container to disappear after 3 seconds
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
                self.weatherMainCollectionView.reloadData()
            }
            
        }
    }
    
    //MARK:- CollectionView Datasource methods. hard coded to return 1. but I would do it dynamic
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfItemsInSection
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let _cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherMainCollectionViewCell
        _cell.findWeatherDelegate = self
        _cell.configureCollectionViewCell(data: viewModel)
        return _cell
    }
    
    //MARK:- UICollectionViewDelegateFlowLayout methods. By default we are setting the height of Item equal to the window bounderies
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.weatherMainCollectionView.frame.height)
    }
    
    //This Perticular method get called from UICollection view cell after click on find Weather for perticular city
    func getDesiredCityInformation(data city: String?) {
        guard let city = city else { return }
        if city.isEmpty || city == "" {
            let alert = UIAlertController(title: "Required", message: "Plese enter the City Name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        fetchWeatherReport(input: city)
    }
    
}

