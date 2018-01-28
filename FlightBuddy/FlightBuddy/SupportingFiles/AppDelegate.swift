//
//  AppDelegate.swift
//  FlightBuddy
//
//  Created by Wilson Ding on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit
import AVFoundation
import PKHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let signal = Signal.instance

    let defaults = UserDefaults.standard

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Access the shared, singleton audio session instance
        let session = AVAudioSession.sharedInstance()
        do {
            // Configure the audio session for movie playback
            if #available(iOS 10.0, *) {
                try session.setCategory(AVAudioSessionCategoryAmbient,
                                        mode: AVAudioSessionModeDefault,
                                        options: [])
                try session.setActive(true)
            } else {
                // Fallback on earlier versions
            }
        } catch let error as NSError {
            print("Failed to set the audio session category and mode: \(error.localizedDescription)")
        }

        let flight = FlightService.instance.getCurrentFlight()
        signal.initialize(serviceType: flight.value)
        signal.delegate = self
        signal.autoConnect()

        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        signal.autoConnect()
        setActiveStatus()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        signal.autoConnect()
        setActiveStatus()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        setLoginStatus()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        setLoginStatus()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        setLoginStatus()
    }

    func setLoginStatus() {
        guard let userSettings = self.defaults.object(forKey: "userString") as! String?,
            !userSettings.isEmpty else {
            return
        }

        let statusUpdate = "\(userSettings)|1"

        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
    }

    func setActiveStatus() {
        guard let userSettings = self.defaults.object(forKey: "userString") as! String?,
            !userSettings.isEmpty else {
            return
        }

        let statusUpdate = "\(userSettings)|2"

        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
    }
}

extension AppDelegate: SignalDelegate {
    func signal(didReceiveData data: Data, ofType type: UInt32) {
        if type == DataType.weather.rawValue {
            let string = data.convert() as! String
            FlightService.instance.setWeather(weatherStr: string)
            print("Set weather...")
        } else if type == DataType.flight.rawValue {
            let string = data.convert() as! String
            FlightService.instance.setCurrentFlight(flight: Flight(flightInfo: string))
            print("Set flight...")
        } else if type == DataType.foodResponse.rawValue {
            guard let userSettings = self.defaults.object(forKey: "userString") as! String?,
                !userSettings.isEmpty else {
                    return
            }

            let string = data.convert() as! String

            if let r = userSettings.range(of: "|", options: .backwards) {
                let seat = userSettings.substring(from: r.upperBound)

                if string == seat {
                    HUD.flash(.success, delay: 2.0)
                    setActiveStatus()
                }
            }
        } else if type == DataType.helpResponse.rawValue {
            guard let userSettings = self.defaults.object(forKey: "userString") as! String?,
                !userSettings.isEmpty else {
                    return
            }

            let string = data.convert() as! String

            if let r = userSettings.range(of: "|", options: .backwards) {
                let seat = userSettings.substring(from: r.upperBound)

                if string == seat {
                    HUD.flash(.success, delay: 2.0)
                    setActiveStatus()
                }
            }
        } else if type == DataType.seatlay.rawValue {
            FlightService.instance.setFlightLayout(image: UIImage(named: "seatlay")!)
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
