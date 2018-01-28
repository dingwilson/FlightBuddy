//
//  ViewController.swift
//  FlightBuddy Hub
//
//  Created by Wilson Ding on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let flightService = FlightService.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load called...")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didPressJoinButton(_ sender: UIButton) {
        print("Pressed button...")
        let flight: Flight = Constants.flightList[0];
        self.startConnection(flight: flight)
    }
    
    
    private func startConnection(flight: Flight) {
        flightService.setCurrentFlight(flight: flight)
        performSegue(withIdentifier: "toFlightView", sender: self)
    }
}




