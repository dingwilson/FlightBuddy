//
//  FoodRequestViewController.swift
//  FlightBuddy
//
//  Created by Kevin J Nguyen on 1/28/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit
import PKHUD

class FoodRequestViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var pickerDataSource: [String] = Constants.drinks
    let signal = Signal.instance

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var pickerView: UIPickerView!

    let drinks = ["water", "soda", "juice", "beer", "wine"]
    let snacks = ["pretzel", "nuts", "chips", "fruit", "chocolate"]
    let entrees = ["sandwich", "chicken_parmesan", "salad", "steak_wrap"]

    var checkoutItem: String = Constants.drinks[0]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPickerView()
    }

    func setupPickerView() {
        pickerView.delegate = self
        segmentedControl.setTitle("Drinks", forSegmentAt: 0)
        segmentedControl.setTitle("Snacks", forSegmentAt: 1)
        segmentedControl.setTitle("Entrees", forSegmentAt: 2)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            self.pickerDataSource = Constants.drinks
            break
        case 1:
            self.pickerDataSource = Constants.snacks
            break
        case 2:
            self.pickerDataSource = Constants.entrees
            break
        default:
            break
        }
        self.pickerView.reloadAllComponents()
    }

    @IBAction func checkout(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToVCSuccess", sender: self)
    }

    @IBAction func didPressBackButton(_ sender: Any) {
        setActiveStatus()
        self.performSegue(withIdentifier: "unwindToVC", sender: self)
    }

    func setActiveStatus() {
        guard let userSettings = self.defaults.object(forKey: "userString") else {
            return
        }

        let statusUpdate = "\(userSettings)|2"

        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
    }

    func setNewImage(image: UIImage) {
        UIView.transition(with: self.imageView,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: { self.imageView.image = image },
                          completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToVC" {
            setActiveStatus()
        } else if segue.identifier == "unwindToVCSuccess" {
            guard let userSettings = self.defaults.object(forKey: "userString") else {
                return
            }

            let statusUpdate = "\(userSettings)|4|\(self.pickerDataSource[self.pickerView.selectedRow(inComponent: 0)])"

            signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
        }
    }
}

extension FoodRequestViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            setNewImage(image: UIImage(named: drinks[row])!)
            break
        case 1:
            setNewImage(image: UIImage(named: snacks[row])!)
            break
        case 2:
            setNewImage(image: UIImage(named: entrees[row])!)
            break
        default:
            break
        }
        return NSAttributedString(string: pickerDataSource[row], attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerDataSource[row])
    }
}
