//
//  FlightService.swift
//  FlightBuddy Hub
//
//  Created by Kevin J Nguyen on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import Foundation

class FlightService {
    var currentFlight: Flight = Flight(value: "", displayName: "")
    
    static let instance = FlightService()
    
    init() {
        log(m: "Initializing flight service...")
    }
    
    func setCurrentFlight(flight: Flight) {
        log(m: "Setting current flight to: \(flight.displayName): \(flight.value)...")
        self.currentFlight.displayName = flight.displayName
        self.currentFlight.value = flight.value
    }
    
    func getCurrentFlight() -> Flight {
        log(m: "Grabbing current flight...")
        return Flight(value: currentFlight.value, displayName: currentFlight.displayName)
    }
    
    private func log(m: String) {
        print("FLIGHT SERVICE: \(m)")
    }
}
