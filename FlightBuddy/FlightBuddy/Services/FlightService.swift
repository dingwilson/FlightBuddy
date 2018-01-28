//
//  FlightService.swift
//  FlightBuddy
//
//  Created by Kevin J Nguyen on 1/28/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import Foundation

class FlightService {
    var currentFlight: Flight = Flight(flightInfo: Constants.flightInfo)
    var weather: Weather = Weather(weatherStr: Constants.weatherStr)
    
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
        return currentFlight;
    }
    
    func getCurrentWeather() -> Weather {
        return self.weather
    }
    
    func setWeather(weatherStr: String) {
        self.weather = Weather(weatherStr: weatherStr)
    }
    
    private func log(m: String) {
        print("FLIGHT SERVICE: \(m)")
    }
}
