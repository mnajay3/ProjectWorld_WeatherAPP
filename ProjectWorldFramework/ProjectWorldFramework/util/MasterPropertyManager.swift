//
//  MasterPropertyManager.swift
//  ProjectWorldFramework
//
//  Created by Naga Murala on 9/27/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import Foundation

//Singleton object to access property list
public var masterPropertyManager: MasterPropertyManager {
    return MasterPropertyManager.sharedInstance
}

public class MasterPropertyManager {
    fileprivate static let sharedInstance = MasterPropertyManager()
    
    //Intended to use shared instance out side of the class
    fileprivate init() {}
    
    //Method to pull the single keyConfiguration from plist
    public func loadKeyConfigurationsFor(_ name: String) -> Any? {
        let _config = MasterPListUtil().findPlistDictionary(KEY_CONFIGURATION,resourceName: MASTER_INFO_RESOURCE)
        if let __config = _config {
            return __config[name]
        }
        return nil
    }
    
    //Method to pull the pageConfigurations from plist for UI navigations
    public func loadPageConfigurationsFor(_ name: String) -> [String: Any]? {
        let _config = MasterPListUtil().findPlistDictionary(PAGE_CONFIGURATION,resourceName: MASTER_INFO_RESOURCE)
        if let __config = _config {
            return __config[name] as? [String: Any]
        }
        return nil
    }
    
    //Method to get UINavigation configuration information from _config dictionary
    public func loadSegueDetailsFromPageConfig(pageConfig: [String:Any]?, segueAlias: String) -> (String?, String?) {
        guard let __config = pageConfig?[SEGUES] else { return (nil, nil)}
        guard let ___config = (__config as! [String: Any])[segueAlias] else { return (nil,nil)}
        guard let _nextViewName = (___config as! [String: Any])[VIEW_NAME] else { return (nil, nil)}
        guard let _nextstoryBoard = (___config as! [String: Any])[STORY_BOARD] else { return (nil,nil)}
        return (_nextViewName as? String, _nextstoryBoard as? String)
    }
    
}
