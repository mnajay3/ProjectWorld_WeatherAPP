//
//  StringExtensions.swift
//  ProjectWorldFramework
//
//  Created by Naga Murala on 9/27/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import Foundation

extension UIApplication {
    var statusBarView : UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

extension UIView {
    func addConstraintsWithTheFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}


extension String {
    
    public func toMiles() -> String? {
        if self.isEmpty { return nil }
        var stringWithoutChars: String?
        if self.contains("SKM"){
            stringWithoutChars = self.replacingOccurrences(of: "SKM", with: "")
        }
        guard let skmInt = Double(stringWithoutChars!) else { return "" }
        let miles = Float(skmInt * 0.621371)
        return "\(miles) Miles"
    }
    
}
