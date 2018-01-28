//
//  ViewController.swift
//  FlightBuddy
//
//  Created by Wilson Ding on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let defaults = UserDefaults.standard
    let signal = Signal.instance

    override func viewDidLoad() {
        super.viewDidLoad()

        setLoginStatus()
        getStatus()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        setLoginStatus()
    }
    
    func getStatus() {
        let flight = FlightService.instance.getCurrentFlight()
        let weather = FlightService.instance.getCurrentWeather()
        print(flight.boardingTime)
    }

    func setLoginStatus() {
        guard let userSettings = self.defaults.object(forKey: "userString") else {
            return
        }

        let statusUpdate = "\(userSettings)|1"
        
        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
    }

    @IBAction func didPressStatus2(_ sender: Any) {
        guard let userSettings = self.defaults.object(forKey: "userString") else {
            return
        }
        
        let statusUpdate = "\(userSettings)|2"
        
        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
    }

    @IBAction func didPressStatus3(_ sender: Any) {
        guard let userSettings = self.defaults.object(forKey: "userString") else {
            return
        }
        
        let statusUpdate = "\(userSettings)|3"
        
        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
    }

    @IBAction func didPressStatus4(_ sender: Any) {
        guard let userSettings = self.defaults.object(forKey: "userString") else {
            return
        }
        
        let statusUpdate = "\(userSettings)|4"
        
        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
    }
}
