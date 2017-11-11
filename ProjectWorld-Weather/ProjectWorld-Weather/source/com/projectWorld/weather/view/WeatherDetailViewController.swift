//
//  WeatherDetailViewController.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 11/11/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import UIKit

//This view controller is only for the demonstration purpose. To explain about the ProjectWorldframeWork Plist implementation classes and MasterviewController behavior

class WeatherDetailViewController: UIViewController {

    let containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let demonstrationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 6
        label.textAlignment = .center
        label.text = "This VC is only to demonstrate about ProjectWorldFrameWork plist util classes functionality and behavior and MasterView Controller functionality support. This VC presentation is handling by frameWork with the help of PLIST"
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor(white: 0.9, alpha: 0.5)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        self.view.addSubview(containerView)
        self.view.addSubview(backButton)
        self.containerView.addSubview(demonstrationLabel)
        addConstraints()
    }
   
    func addConstraints() {
        self.view.addConstraint(NSLayoutConstraint(item: self.containerView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.containerView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
        self.containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.demonstrationLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor).isActive = true
        self.demonstrationLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor).isActive = true
        self.demonstrationLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        self.demonstrationLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        
    }
    
    @objc func handleButton() {
        self.dismiss(animated: true, completion: nil)
    }


}
