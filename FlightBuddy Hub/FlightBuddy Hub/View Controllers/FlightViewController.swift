//
//  FlightViewController.swift
//  FlightBuddy Hub
//
//  Created by Kevin J Nguyen on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit

enum seatStatus {
    case defult, checkedin
}

class FlightViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let signal = Signal.instance

    @IBOutlet weak var seat12A: UIButton!
    @IBOutlet weak var seat12B: UIButton!
    @IBOutlet weak var seat12C: UIButton!
    @IBOutlet weak var seat12D: UIButton!
    @IBOutlet weak var seat12E: UIButton!
    @IBOutlet weak var seat12F: UIButton!
    
    @IBOutlet weak var seat13A: UIButton!
    @IBOutlet weak var seat13B: UIButton!
    @IBOutlet weak var seat13C: UIButton!
    @IBOutlet weak var seat13D: UIButton!
    @IBOutlet weak var seat13E: UIButton!
    @IBOutlet weak var seat13F: UIButton!
    
    @IBOutlet weak var seat14A: UIButton!
    @IBOutlet weak var seat14B: UIButton!
    @IBOutlet weak var seat14C: UIButton!
    @IBOutlet weak var seat14D: UIButton!
    @IBOutlet weak var seat14E: UIButton!
    @IBOutlet weak var seat14F: UIButton!
    
    private let startingRow: Int = 12
    private var row12: [UIButton] = []
    private var row13: [UIButton] = []
    private var row14: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let flight = FlightService.instance.getCurrentFlight()
        
        print("Starting service as: \(flight.value)")
        signal.initialize(serviceType: flight.value )
        print("Setting signal delegate...")
        self.signal.delegate = self
        print("Enabling auto connect...")
        self.signal.autoConnect()
        
        self.log(m: "Adding references to row arrays")
        row12.append(seat12A)
        row12.append(seat12B)
        row12.append(seat12C)
        row12.append(seat12D)
        row12.append(seat12D)
        row12.append(seat12E)
        row12.append(seat12F)
        
        row13.append(seat13A)
        row13.append(seat13B)
        row13.append(seat13C)
        row13.append(seat13D)
        row13.append(seat13D)
        row13.append(seat13E)
        row13.append(seat13F)
        
        row14.append(seat14A)
        row14.append(seat14B)
        row14.append(seat14C)
        row14.append(seat14D)
        row14.append(seat14D)
        row14.append(seat14E)
        row14.append(seat14F)
        
        for button in self.row12 {
            button.backgroundColor = Constants.defaultColor
        }
        
        for button in self.row13 {
            button.backgroundColor = Constants.defaultColor
        }
        
        for button in self.row14 {
            button.backgroundColor = Constants.defaultColor
        }
    }

    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    private func updateSeat(seat: Seat) {
        var rowRef: [UIButton]? = nil
        if (seat.seatRow == "12") {
            rowRef = self.row12
        } else if (seat.seatRow == "13") {
            rowRef = self.row13
        } else if (seat.seatRow == "14") {
            rowRef = self.row14
        }
        
        if (rowRef == nil) {
            return
        }
        
        let buttonRef = rowRef![seat.seatIndex]
        
        if (seat.status == "1") {
            buttonRef.backgroundColor = Constants.checkedinColor
        } else if (seat.status == "2") {
            buttonRef.backgroundColor = Constants.activeColor
        } else if (seat.status == "3") {
            buttonRef.backgroundColor = Constants.requestColor
        } else if (seat.status == "4") {
            buttonRef.backgroundColor = Constants.helpColor
        }
        
    }
    
    private func log(m: String) {
        print("FVC: \(m)")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FlightViewController: SignalDelegate {
    func signal(didReceiveData data: Data, ofType type: UInt32) {
        if type == DataType.string.rawValue {
            let string = data.convert() as! String
            let seat = Seat.convertStringToSeat(seat: string)
            self.updateSeat(seat: seat)
        }
    }
    
    func signal(connectedDevicesChanged devices: [String]) {
        if (devices.count > 0) {
            print("Connected Devices: \(devices)")
            self.sendFlightData()
            self.sendWeatherData()
        } else {
            print("No devices connected")
        }
    }
    
    func sendWeatherData() {
        signal.sendObject(object: Constants.weatherStr, type: DataType.weather.rawValue)
    }
    
    func sendFlightData() {
        signal.sendObject(object: Constants.flightInfo, type: DataType.flight.rawValue)
    }
    
}
