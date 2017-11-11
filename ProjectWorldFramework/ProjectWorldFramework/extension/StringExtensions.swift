//
//  StringExtensions.swift
//  ProjectWorldFramework
//
//  Created by Naga Murala on 9/27/17.
//  Copyright © 2017 Naga Murala. All rights reserved.
//

import Foundation

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
    
    
    public func toCharArray() -> [Character]? {
        var stringChars: [Character] = [Character]()
        for char in self.characters {
            stringChars.append(char)
        }
        return stringChars
    }
    
}
