//
//  ViewController.swift
//  FlightBuddy
//
//  Created by Wilson Ding on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit
import PKHUD

class MainViewController: UIViewController {

    let defaults = UserDefaults.standard
    let signal = Signal.instance

    var waitingOnFA = false

    override func viewDidLoad() {
        super.viewDidLoad()

        setLoginStatus()
        getStatus()

        PKHUD.sharedHUD.dimsBackground = true
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        setLoginStatus()
        setActiveStatus()
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

    func setActiveStatus() {
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

        waitingOnFA = true
        HUD.show(.progress)
    }
}
