//
//  DayTemparatureView.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 01/09/18.
//  Copyright © 2018 Naga Murala. All rights reserved.
//

import UIKit

class DayTemparatureView: UIView {

    let containerView : UIView = {
        let cv = UIView()
        cv.backgroundColor = .clear//UIColor(white: 0, alpha: 0.5)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    let dayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Friday"
        label.sizeToFit()
        label.textColor = .white
        return label
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Today"
        label.textColor = .white
        return label
    }()
    let minTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "6"
        label.textColor = .white
        return label
    }()
    let maxTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "7"
        label.textColor = .white
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
//        addSubview(containerView)
//        containerView.addSubview(dayNameLabel)
//        containerView.addSubview(dayLabel)
//        containerView.addSubview(maxTemp)
//        containerView.addSubview(minTemp)
        
        
//        addConstraints()
    }
    func addConstraints() {
        //Setting the constaints to container view
        containerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        
        //Adding day name label to the container view
        self.dayNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        self.dayNameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        self.dayNameLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 5).isActive = true
//        self.dayNameLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        //Adding day name label to the container view
        self.dayLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        self.dayLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
//        self.dayLabel.leftAnchor.constraint(equalTo: self.dayNameLabel.rightAnchor, constant: 5).isActive = true
        
        self.maxTemp.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        self.maxTemp.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        self.maxTemp.rightAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        self.minTemp.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        self.minTemp.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
//        self.minTemp.rightAnchor.constraint(equalTo: maxTemp.leftAnchor, constant: 0)
    }
}
