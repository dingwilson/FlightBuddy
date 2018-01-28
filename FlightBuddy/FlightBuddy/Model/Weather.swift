//
//  Weather.swift
//  FlightBuddy
//
//  Created by Kevin J Nguyen on 1/28/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import Foundation

class Weather {
    var description: String = ""
    var degrees: String = ""
    
    init(weatherStr: String) {
        let strComp = weatherStr.components(separatedBy: "|")
        if (strComp[0] == "W") {
            self.description = strComp[1]
            self.degrees = strComp[2]
        }
    }
}
