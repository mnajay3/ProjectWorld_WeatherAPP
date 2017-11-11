//
//  extension.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 11/9/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView : UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
