//
//  EntertainmentViewController.swift
//  FlightBuddy
//
//  Created by Wilson Ding on 1/28/18.
//  Copyright © 2018 Wilson Ding. All rights reserved.
//

import UIKit

class EntertainmentViewController: UIViewController {

    @IBOutlet weak var tvButton: TVButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupKylo()
    }

    func setupKylo() {
        let background = TVButtonLayer(image: UIImage(named: "KyloA.png")!)
        let pattern = TVButtonLayer(image: UIImage(named: "KyloB.png")!)
        let top = TVButtonLayer(image: UIImage(named: "KyloC.png")!)
        let uberTop = TVButtonLayer(image: UIImage(named: "KyloE.png")!)
        tvButton.layers = [background, pattern, uberTop, top]
        tvButton.parallaxIntensity = 1
    }

}
