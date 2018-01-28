//
//  ViewController.swift
//  FlightBuddy
//
//  Created by Wilson Ding on 1/27/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit
import PKHUD

class MainViewController: UIViewController, UIGestureRecognizerDelegate, UIScrollViewDelegate  {

    let defaults = UserDefaults.standard
    let signal = Signal.instance

    var waitingOnFA = false

    var imageView: UIImageView!
    var scrollImg: UIScrollView!
    
    @IBOutlet weak var weatherDescLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var departTime: UILabel!
    @IBOutlet weak var templabel: UILabel!
    @IBOutlet weak var arriveTime: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setActiveStatus()
        setLabels()

        PKHUD.sharedHUD.dimsBackground = true
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
    }
    
    func setLabels() {
        let flight = FlightService.instance.getCurrentFlight()
        let weather = FlightService.instance.getCurrentWeather()
        self.weatherDescLabel.text = weather.description
        self.templabel.text = weather.degrees
        self.flightNumberLabel.text = flight.displayName
        self.departTime.text = flight.flightTime
        self.arriveTime.text = Constants.arriveTime
        
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
        
        self.performSegue(withIdentifier: "toFoodRequestView", sender: self)
    }

    @IBAction func didPressStatus4(_ sender: Any) {
        guard let userSettings = self.defaults.object(forKey: "userString") else {
            return
        }
        
        let statusUpdate = "\(userSettings)|4"
        
        signal.sendObject(object: statusUpdate, type: DataType.string.rawValue)

        waitingOnFA = true
        HUD.show(.progress)
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
        imageView.image = FlightService.instance.getFlightLayout()
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

