//
//  ViewController.swift
//  FlightBuddy
//
//  Created by Wilson Ding on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let signal = Signal.instance

    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        signal.initialize(serviceType: Constants.flightList[0].value)
        signal.delegate = self

        signal.autoConnect()
    }
}

extension MainViewController: SignalDelegate {
    func signal(didReceiveData data: Data, ofType type: UInt32) {
        if type == DataType.string.rawValue {
            let string = data.convert() as! String
            print(string)
        }
    }

    func signal(connectedDevicesChanged devices: [String]) {
        if (devices.count > 0) {
            print("Connected Devices: \(devices)")
        } else {
            print("No devices connected")
        }
    }

}

