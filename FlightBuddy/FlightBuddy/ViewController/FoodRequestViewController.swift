//
//  FoodRequestViewController.swift
//  FlightBuddy
//
//  Created by Kevin J Nguyen on 1/28/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit
import PKHUD

class FoodRequestViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let defaults = UserDefaults.standard
    var pickerDataSource: [String] = Constants.drinks
    let signal = Signal.instance

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var pickerView: UIPickerView!
    var checkoutItem: String = Constants.drinks[0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        segmentedControl.setTitle("Drinks", forSegmentAt: 0)
        segmentedControl.setTitle("Snacks", forSegmentAt: 1)
        segmentedControl.setTitle("Entres", forSegmentAt: 2)
        
        guard let userSettings = self.defaults.object(forKey: "userString") else {
            return
        }
        
        let statusUpdate = "\(userSettings)|3"
        
        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        print(pickerDataSource[row])
    }

    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            self.pickerDataSource = Constants.drinks
        case 1:
            self.pickerDataSource = Constants.snacks
        case 2:
            self.pickerDataSource = Constants.entres

        default:
            break
        }
        self.pickerView.reloadAllComponents()
    }
    
    @IBAction func checkout(_ sender: UIButton) {
        guard let userSettings = self.defaults.object(forKey: "userString") else {
            return
        }

        let statusUpdate = "\(userSettings)|4|\(self.pickerDataSource[self.pickerView.selectedRow(inComponent: 0)])"
        
        HUD.show(.progress)
        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
        
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
