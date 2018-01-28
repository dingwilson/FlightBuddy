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
    @IBOutlet weak var tableView: UITableView!
    
    let signal = Signal.instance
    var orders: [Seat] = []

    @IBOutlet weak var flightLabel: UILabel!
    
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
    
    @IBOutlet weak var seat15A: UIButton!
    @IBOutlet weak var seat15B: UIButton!
    @IBOutlet weak var seat15C: UIButton!
    @IBOutlet weak var seat15D: UIButton!
    @IBOutlet weak var seat15E: UIButton!
    @IBOutlet weak var seat15F: UIButton!
    
    @IBOutlet weak var seat16A: UIButton!
    @IBOutlet weak var seat16B: UIButton!
    @IBOutlet weak var seat16C: UIButton!
    @IBOutlet weak var seat16D: UIButton!
    @IBOutlet weak var seat16E: UIButton!
    @IBOutlet weak var seat16F: UIButton!

    private let startingRow: Int = 12
    private var row12: [UIButton] = []
    private var row13: [UIButton] = []
    private var row14: [UIButton] = []
    private var row15: [UIButton] = []
    private var row16: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let flight = FlightService.instance.getCurrentFlight()

        flightLabel.text = flight.displayName

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
        row12.append(seat12E)
        row12.append(seat12F)
        
        row13.append(seat13A)
        row13.append(seat13B)
        row13.append(seat13C)
        row13.append(seat13D)
        row13.append(seat13E)
        row13.append(seat13F)
        
        row14.append(seat14A)
        row14.append(seat14B)
        row14.append(seat14C)
        row14.append(seat14D)
        row14.append(seat14E)
        row14.append(seat14F)
        
        row15.append(seat15A)
        row15.append(seat15B)
        row15.append(seat15C)
        row15.append(seat15D)
        row15.append(seat15E)
        row15.append(seat15F)
        
        row16.append(seat16A)
        row16.append(seat16B)
        row16.append(seat16C)
        row16.append(seat16D)
        row16.append(seat16E)
        row16.append(seat16F)
        
        for button in self.row12 {
            button.backgroundColor = Constants.defaultColor
        }
        
        for button in self.row13 {
            button.backgroundColor = Constants.defaultColor
        }
        
        for button in self.row14 {
            button.backgroundColor = Constants.defaultColor
        }
        
        for button in self.row15 {
            button.backgroundColor = Constants.defaultColor
        }
        
        for button in self.row16 {
            button.backgroundColor = Constants.defaultColor
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    private func itemFromList(seat: String) {
        self.orders = self.orders.filter { !($0.seat == seat) }
        self.tableView.reloadData()
    }

    private func updateSeat(seat: Seat) {
        var rowRef: [UIButton]? = nil
        if (seat.seatRow == "12") {
            rowRef = self.row12
        } else if (seat.seatRow == "13") {
            rowRef = self.row13
        } else if (seat.seatRow == "14") {
            rowRef = self.row14
        } else if (seat.seatRow == "15") {
            rowRef = self.row15
        } else if (seat.seatRow == "16") {
            rowRef = self.row16
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
            self.addItem(seat: seat)
        }
        
        
    }
    
    private func addItem(seat: Seat) {
        if (seat.statusInformation.count == 0) {
            seat.statusInformation = "Help"
        }
        self.orders.append(seat)
        self.tableView.reloadData()
    }
    
    private func log(m: String) {
        print("FVC: \(m)")
    }

    @IBAction func didPressSeatButton(_ sender: UIButton) {
        switch(sender){
        case seat12A: if let buttonStatus = seat12A.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "12A")
                sendHelpResponse(seat: "12A")
            }
        }
            break
            
        case seat12B: if let buttonStatus = seat12B.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "12B")
                sendHelpResponse(seat: "12B")
            }
        }
            break
            
        case seat12C: if let buttonStatus = seat12C.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "12C")
                sendHelpResponse(seat: "12C")
            }
        }
            break
            
        case seat12D: if let buttonStatus = seat12D.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "12D")
                sendHelpResponse(seat: "12D")
            }
        }
            break
            
        case seat12E: if let buttonStatus = seat12E.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "12E")
                sendHelpResponse(seat: "12E")
            }
        }
            break
            
        case seat12F: if let buttonStatus = seat12F.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "12F")
                sendHelpResponse(seat: "12F")
            }
        }
            break
            
            
        case seat13A: if let buttonStatus = seat13A.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "13A")
                sendHelpResponse(seat: "13A")
            }
        }
            break
            
        case seat13B: if let buttonStatus = seat13B.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "13B")
                sendHelpResponse(seat: "13B")
            }
        }
            break
            
        case seat13C: if let buttonStatus = seat13C.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "13C")
                sendHelpResponse(seat: "13C")
            }
        }
            break
            
        case seat13D: if let buttonStatus = seat13D.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "13D")
                sendHelpResponse(seat: "13D")
            }
        }
            break
            
        case seat13E: if let buttonStatus = seat13E.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "13E")
                sendHelpResponse(seat: "13E")
            }
        }
            break
            
        case seat13F: if let buttonStatus = seat13F.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "13F")
                sendHelpResponse(seat: "13F")
            }
        }
            break
            
            
        case seat14A: if let buttonStatus = seat14A.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "14A")
                sendHelpResponse(seat: "14A")
            }
        }
            break
            
        case seat14B: if let buttonStatus = seat14B.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "14B")
                sendHelpResponse(seat: "14B")
            }
        }
            break
            
        case seat14C: if let buttonStatus = seat14C.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "14C")
                sendHelpResponse(seat: "14C")
            }
        }
            break
            
        case seat14D: if let buttonStatus = seat14D.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "14D")
                sendHelpResponse(seat: "14D")
            }
        }
            break
            
        case seat14E: if let buttonStatus = seat14E.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "14E")
                sendHelpResponse(seat: "14E")
            }
        }
            break
            
        case seat14F: if let buttonStatus = seat14F.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat: "14F")
                sendHelpResponse(seat: "14F")
            }
        }
            break
            
            
        case seat15A: if let buttonStatus = seat15A.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat:"15A")
                sendHelpResponse(seat: "15A")
            }
        }
            break
            
        case seat15B: if let buttonStatus = seat15B.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat:"15B")
                sendHelpResponse(seat: "15B")
            }
        }
            break
            
        case seat15C: if let buttonStatus = seat15C.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat:"15C")
                sendHelpResponse(seat: "15C")
            }
        }
            break
            
        case seat15D: if let buttonStatus = seat15D.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat:"15D")
                sendHelpResponse(seat: "15D")
            }
        }
            break
            
        case seat15E: if let buttonStatus = seat15E.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat:"15E")
                sendHelpResponse(seat: "15E")
            }
        }
            break
            
        case seat15F: if let buttonStatus = seat15F.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat:"15F")
                sendHelpResponse(seat: "15F")
            }
        }
            break
            
            
        case seat16A: if let buttonStatus = seat16A.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat:"16A")
                sendHelpResponse(seat: "16A")
            }
        }
            break
            
        case seat16B: if let buttonStatus = seat16B.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat:"16B")
                sendHelpResponse(seat: "16B")
            }
        }
            break
            
        case seat16C: if let buttonStatus = seat16C.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat:"16C")
                sendHelpResponse(seat: "16C")
            }
        }
            break
            
        case seat16D: if let buttonStatus = seat16D.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat:"16D")
                sendHelpResponse(seat: "16D")
            }
        }
            break
            
        case seat16E: if let buttonStatus = seat16E.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat:"16E")
                sendHelpResponse(seat: "16E")
            }
        }
            break
            
        case seat16F: if let buttonStatus = seat16F.backgroundColor {
            if buttonStatus == Constants.helpColor {
                self.itemFromList(seat:"16F")
                sendHelpResponse(seat: "16F")
            }
        }
        break
        default:
            break
        }
    }
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
            self.sendSeatLayoutPic()
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
    func sendFoodResponse(seat: String) {
        signal.sendObject(object: seat, type: DataType.foodResponse.rawValue)
    }

    func sendHelpResponse(seat: String) {
        signal.sendObject(object: seat, type: DataType.helpResponse.rawValue)
    }
    
    func sendSeatLayoutPic() {
        let image = UIImage(named: "seatlay")!
        var data: Data?
        
        if let cgImage = image.cgImage, cgImage.renderingIntent == .defaultIntent {
            data = UIImageJPEGRepresentation(image, 0.8)
        }
        else {
            data = UIImagePNGRepresentation(image)
        }
        signal.sendObject(object: data!, type: DataType.seatlay.rawValue)
    }
    
}

extension FlightViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(self.orders[indexPath.row].seat): \(self.orders[indexPath.row].statusInformation)"
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
}
