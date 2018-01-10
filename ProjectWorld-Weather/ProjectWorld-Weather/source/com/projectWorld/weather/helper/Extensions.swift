//
//  extension.swift
//  ProjectWorld-Weather
//
//  Created by Naga Murala on 01/09/18.
//  Copyright © 2018 Naga Murala. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView : UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
