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
    
    static var gateNumber: String = "38A"
    static var boardingTime: String = "10:45 AM"
    static var flightTime: String = "11:00 AM"
    
    static var weatherStr: String = "W|Partly Cloudy|62F"
    
    static var fromAirport: String = "DFW"
    static var toAirport: String = "ORD"
    
    static var flightList = [
        Flight(flightInfo: Constants.flightInfo)
    ]
    
    static var flightInfo = "F|flight-123|Flight 123|38A|10:45AM|11:00AM|DFW|ORD"
    static var arriveTime = "1:20 PM"
    static var drinks = ["Water", "Soda", "Juice", "Beer (5)", "Wine (4)"]
    static var snacks = ["Pretzels (1)", "Nuts (1)", "Chips (2)", "Fruit (2)", "Chocolate (3)"]
    static var entres = ["Sandwich (5)", "Chicken Parmesan (8)", "Salad (4)", "Steak Wrap (10)"]
}


