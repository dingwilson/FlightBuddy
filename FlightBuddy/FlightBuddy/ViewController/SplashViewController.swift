//
//  SplashViewController.swift
//  FlightBuddy
//
//  Created by Wilson Ding on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit
import SwiftVideoBackground
import BarcodeScanner

class SplashViewController: UIViewController {
    private let videoBackground = VideoBackground()

    let defaults = UserDefaults.standard

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        clearUserDefaults()

        setupVideoBackground()

        setupBarcodeScannerText()
    }

    func clearUserDefaults() {
        defaults.set("", forKey: "userString")
    }

    func setupVideoBackground() {
        videoBackground.play(view: view, videoName: "Background", videoType: "mp4")
    }

    func setupBarcodeScannerText() {
        BarcodeScanner.Title.text = NSLocalizedString("Scan Boarding Pass", comment: "")
        BarcodeScanner.CloseButton.text = NSLocalizedString("Close", comment: "")
        BarcodeScanner.SettingsButton.text = NSLocalizedString("Settings", comment: "")
        BarcodeScanner.Info.text = NSLocalizedString(
            "Place the boarding pass within the window.", comment: "")
        BarcodeScanner.Info.loadingText = NSLocalizedString("Searching passenger manifest...", comment: "")
        BarcodeScanner.Info.notFoundText = NSLocalizedString("You could not be found.", comment: "")
        BarcodeScanner.Info.settingsText = NSLocalizedString(
            "In order to scan your boarding pass, you have to allow camera access in your settings.", comment: "")

        let darkBlue: UIColor = UIColor(red:0.07, green:0.39, blue:0.60, alpha:1.0)

        BarcodeScanner.Title.color = darkBlue
        BarcodeScanner.CloseButton.color = darkBlue
        BarcodeScanner.SettingsButton.color = UIColor.white
        BarcodeScanner.Info.textColor = darkBlue
        BarcodeScanner.Info.tint = darkBlue
        BarcodeScanner.Info.loadingTint = darkBlue
        BarcodeScanner.Info.notFoundTint = UIColor.red
    }

    @IBAction func didPressStartButton(_ sender: Any) {
        let viewController = BarcodeScannerController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self

        present(viewController, animated: true, completion: nil)
    }
}

// MARK: - BarcodeScannerCodeDelegate
extension SplashViewController: BarcodeScannerCodeDelegate {
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {

        if type == "org.iso.PDF417" && code.contains("|") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.defaults.set(code, forKey: "userString")

                controller.dismiss(animated: true, completion: {() in
                    self.performSegue(withIdentifier: "foundBarcode", sender: self)
                })
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                controller.resetWithError()
            }
        }
    }
}

// MARK: - BarcodeScannerErrorDelegate
extension SplashViewController: BarcodeScannerErrorDelegate {
    func barcodeScanner(_ controller: BarcodeScannerController, didReceiveError error: Error) {
        print(error)
        controller.resetWithError(message: "An unexpected error occured. Please try again.")
    }
}

// MARK: - BarcodeScannerDismissalDelegate
extension SplashViewController: BarcodeScannerDismissalDelegate {
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
