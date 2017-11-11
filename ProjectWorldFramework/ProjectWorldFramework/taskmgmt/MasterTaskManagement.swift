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

//This class is not intended to override. 
//Enabling this functionalities only for client consumption
public class MasterTaskManagement {
    private init(){ }
    fileprivate static var sharedInstance = MasterTaskManagement()
    //Using URLSession for network call by passing url. It's a task management(multiThreading), excute the url in backgroung thread. Once we get the response(data, response, error). We have to handle it and get the Main thread to the top to update the User Interactive information.
    //All these activities are being done on background threads. Client has to make sure to update the userinterface related activities has to run on the mainthred
    public func performTask(url: URL?, block:@escaping BLOCK, completion:@escaping (Data) -> ())
    {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        guard let url = url else { return }
        session.dataTask(with: url){ (data,response,error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error occured during the networking call")
                return
            }
            guard let data = data else {
                print(error?.localizedDescription ?? "Error in Network Data")
                return
            }
                block()
                completion(data)
            }.resume()
    }
}
