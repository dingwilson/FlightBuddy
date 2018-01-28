//
//  AppDelegate.swift
//  FlightBuddy
//
//  Created by Wilson Ding on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let signal = Signal.instance

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

        signal.initialize(serviceType: Constants.flightList[0].value)
        signal.delegate = self

        signal.autoConnect()

        return true
    }
}

extension AppDelegate: SignalDelegate {
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
