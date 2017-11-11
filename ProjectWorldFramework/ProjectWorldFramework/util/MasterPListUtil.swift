//
//  MasterPListUtil.swift
//  ProjectWorldFramework
//
//  Created by Naga Murala on 9/27/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import Foundation

public class MasterPListUtil {
    public init() {}
    
    //Returns Plist values for the main bundle
    public func findPlistValue(_ key: String, resourceName: String=INFO) -> String? {
        let test = findPlistObject(key, resourceName: resourceName)
        return test as? String
    }
    
    //Returns dictionary data from Plist
    public func findPlistDictionary(_ key: String, resourceName: String = INFO) -> [String: Any]? {
        let test = findPlistObject(key, resourceName: resourceName)
        return test as? Dictionary
    }
    
    //Call the main bundle(who ever invokes this framework) from plist as Any
    public func findPlistObject(_ key: String, resourceName: String=INFO) -> Any? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: PLIST) else { return nil }
        let levelblocks = NSDictionary(contentsOfFile: path)
        let ao: Any? = levelblocks?.object(forKey: key)
        return ao
    }
}
