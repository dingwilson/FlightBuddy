//
//  ViewController.swift
//  FlightBuddy
//
//  Created by Wilson Ding on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate  {

    let defaults = UserDefaults.standard
    let signal = Signal.instance
    var imageView: UIImageView!
    var scrollImg: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLoginStatus()
        getStatus()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        setLoginStatus()
        setActiveStatus()
    }
    
    func getStatus() {
        let flight = FlightService.instance.getCurrentFlight()
        let weather = FlightService.instance.getCurrentWeather()
        print(flight.boardingTime)
    }

    func setLoginStatus() {
        guard let userSettings = self.defaults.object(forKey: "userString") else {
            return
        }

        let statusUpdate = "\(userSettings)|1"
        
        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
    }

    func setActiveStatus() {
        guard let userSettings = self.defaults.object(forKey: "userString") else {
            return
        }
        
        let statusUpdate = "\(userSettings)|2"
        
        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
    }

    @IBAction func didPressStatus3(_ sender: Any) {
        guard let userSettings = self.defaults.object(forKey: "userString") else {
            return
        }
        
        let statusUpdate = "\(userSettings)|3"
        
        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
    }

    @IBAction func didPressStatus4(_ sender: Any) {
        guard let userSettings = self.defaults.object(forKey: "userString") else {
            return
        }
        
        let statusUpdate = "\(userSettings)|4"
        
        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)
    }
    
    @IBAction func loadImage(_ sender: UIButton) {
        
        scrollImg = UIScrollView(frame: self.view.bounds)
        scrollImg.delegate = self
        scrollImg.backgroundColor = UIColor(red: 90, green: 90, blue: 90, alpha: 0.90)
        scrollImg.alwaysBounceVertical = false
        scrollImg.alwaysBounceHorizontal = false
        scrollImg.showsVerticalScrollIndicator = true
        scrollImg.flashScrollIndicators()
        
        scrollImg.minimumZoomScale = 1.0
        scrollImg.maximumZoomScale = 10.0
        
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollImg.addGestureRecognizer(doubleTapGest)
        
        self.view.addSubview(scrollImg)
        
        imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "seatlay")
        imageView!.layer.cornerRadius = 11.0
        imageView!.clipsToBounds = false
        
        scrollImg.addSubview(imageView!)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        scrollImg.addGestureRecognizer(tap)
    }
    
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollImg.zoomScale == 1 {
            scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollImg.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = imageView.frame.size.height / scale
        zoomRect.size.width  = imageView.frame.size.width  / scale
        let newCenter = imageView.convert(center, from: scrollImg)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}
