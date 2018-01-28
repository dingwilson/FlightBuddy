//
//  ViewController.swift
//  FlightBuddy Hub
//
//  Created by Wilson Ding on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let signal = Signal.instance
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
        
        print("Starting service as: \(flight.value)")
        signal.initialize(serviceType: flight.value )
        print("Setting signal delegate...")
        signal.delegate = self
        print("Enabling auto connect...")
        signal.autoConnect()
        
        flightService.setCurrentFlight(flight: flight)
        performSegue(withIdentifier: "toFlightView", sender: self)
    }
}



extension ViewController: SignalDelegate {
    func signal(didReceiveData data: Data, ofType type: UInt32) {
        if type == DataType.string.rawValue {
            let string = data.convert() as! String
            print(string)
        }
    }
    
    func signal(connectedDevicesChanged devices: [String]) {
        if (devices.count > 0) {
            print("Connected Devices: \(devices)")
            signal.sendObject(object: "Hello Wilson", type: DataType.string.rawValue)
        } else {
            print("No devices connected")
        }
    }
    
}
