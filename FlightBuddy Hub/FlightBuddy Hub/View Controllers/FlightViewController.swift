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
//        updateSeat(seat: "12A", status: .checkedin)
        let sampleString = "Wilson Ding|14B|3|Food"
        let seat = Seat.convertStringToSeat(seat: sampleString)
        self.updateSeat(seat: seat)
        
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
