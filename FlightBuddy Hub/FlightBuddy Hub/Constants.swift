//
//  Constants.swift
//  FlightBuddy
//
//  Created by Kevin J Nguyen on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    
    static var enableLog: Bool = true;
    
    static var defaultColor: UIColor = UIColor.gray
    static var checkedinColor: UIColor = UIColor.blue
    static var activeColor: UIColor = UIColor.green
    static var requestColor: UIColor = UIColor.yellow
    static var helpColor: UIColor = UIColor.red
    
    static var flightList = [
        Flight(value: "flight-123", displayName: "Flight 123"),
        Flight(value: "flight-321", displayName: "Flight 123")
        
    ]
    
}

