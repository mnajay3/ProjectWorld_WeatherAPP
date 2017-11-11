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
public typealias JSON = [String:Any]
//BLOCK enables user to perform any action immediate after refreshing with the response object from service call
public typealias BLOCK = () -> ()
// delegate confirmation to prepare url before calling the perform task
public protocol MasterTaskManagementDelegate {
    func prepareServiceURL() -> URL?
}

//This class is not intended to inherit. 
//Enabling this functionalities only for consumption
public class MasterTaskManagement {
    private init(){ }
    fileprivate static var sharedInstance = MasterTaskManagement()
    public var serviceDelegate: MasterTaskManagementDelegate?
    public func performTask(delegate: MasterTaskManagementDelegate,
                            block:@escaping BLOCK, completion:@escaping (Data) -> ()) {
        self.serviceDelegate = delegate
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        guard let url = self.prepareURLFromDelegate() else { return }
        session.dataTask(with: url){ (data,response,error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            guard let data = data else {
                print(error?.localizedDescription ?? "Error in Network Data")
                return
            }
            completion(data)
            block()
            }.resume()
    }
    
    public func prepareURLFromDelegate() -> URL? {
        guard let taskMgmtDelegate = self.serviceDelegate else { return nil }
        return taskMgmtDelegate.prepareServiceURL()
    }
    
}
