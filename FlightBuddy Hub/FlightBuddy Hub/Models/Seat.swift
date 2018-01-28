//
//  Seat.swift
//  FlightBuddy Hub
//
//  Created by Kevin J Nguyen on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import Foundation

class Seat {
    
    var name: String = ""
    var seat: String = ""
    var seatRow: String = ""
    var seatIndex: Int = 0
    var status: String = ""
    var statusInformation: String = ""
    
    static func convertStringToSeat(seat: String) -> Seat {
        let conSeat: Seat = Seat()
        
        let seatComponents = seat.components(separatedBy: "|")
        
        conSeat.name = seatComponents[0]
        conSeat.seat = seatComponents[1]
        conSeat.status = seatComponents[2]
        
        let rowIndex = conSeat.seat.index(conSeat.seat.startIndex, offsetBy: 2)
        let rowSubstring = conSeat.seat.prefix(upTo: rowIndex)
        
        let lastChar: Character = conSeat.seat.last!
        let scalars = String(lastChar).unicodeScalars
        let rowSeatIndex = scalars[scalars.startIndex].value - 65
        
        conSeat.seatRow = String(rowSubstring)
        conSeat.seatIndex = Int(rowSeatIndex)
        
        if (seatComponents.count == 4) {
            conSeat.statusInformation = seatComponents[3]
        }
        
        return conSeat
    }
}
