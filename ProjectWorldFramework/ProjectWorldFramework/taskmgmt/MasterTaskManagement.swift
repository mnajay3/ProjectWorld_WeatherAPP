//
//  MasterTaskManagement.swift
//  ProjectWorldFramework
//
//  Created by Naga Murala on 9/27/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import Foundation

//singlton object to prevent duplication of objects
public var masterTaskMgmt : MasterTaskManagement {
    return MasterTaskManagement.sharedInstance
}

// delegate confirmation to prepare url before calling the perform task

public protocol MasterTaskManagementDelegate {
    func prepareServiceURL() -> URL?
}

public typealias JSON = [String:Any]

//This class is not intended to inherit. 
//Enabling this functionalities only for consumption
public class MasterTaskManagement {
    
    private init(){ }
    
    fileprivate static var sharedInstance = MasterTaskManagement()
    public var serviceDelegate: MasterTaskManagementDelegate?
    //BLOCK enables user to perform any action immediate after refreshing with the response object from service call
    public typealias BLOCK = () -> ()
    
    public func performTask(delegate: MasterTaskManagementDelegate, block:@escaping BLOCK, completion:@escaping (Data) -> ()) {
        self.serviceDelegate = delegate
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
        guard let url = self.prepareURLFromDelegate() else { return }
//        guard let url = URL(string: "http://services.groupkt.com/state/get/USA/all") else { return }
            session.dataTask(with: url){ (data,response,error) in
                if error != nil { return }
                guard let data = data else { return }
                completion(data)
                block()
                
            }.resume()
        
    }
    
    public func prepareURLFromDelegate() -> URL? {
        guard let taskMgmtDelegate = self.serviceDelegate else { return nil }
        return taskMgmtDelegate.prepareServiceURL()
    }
    
}
