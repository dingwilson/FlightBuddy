//
//  Flight.swift
//  FlightBuddy
//
//  Created by Kevin J Nguyen on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import Foundation

class Flight {
    
    var value: String = ""
    var displayName: String = ""
    var gateNumber: String = ""
    var boardingTime: String = ""
    var flightTime: String = ""
    var fromAirport: String = ""
    var toAirport: String = ""
    
    init(flightInfo: String) {
        let strComp = flightInfo.components(separatedBy: "|")
        self.value = strComp[1]
        self.displayName = strComp[2]
        self.gateNumber = strComp[3]
        self.boardingTime = strComp[4]
        self.flightTime = strComp[5]
        self.toAirport = strComp[6]
        self.fromAirport = strComp[7]
    }
    
    
}

