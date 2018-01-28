//
//  ViewController.swift
//  FlightBuddy Hub
//
//  Created by Wilson Ding on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.flightList.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return Constants.flightList[row].displayName
//    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        return NSAttributedString(string: Constants.flightList[row].displayName, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
    }
    
    @IBOutlet weak var pickerView: UIPickerView!
    let flightService = FlightService.instance
    
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




