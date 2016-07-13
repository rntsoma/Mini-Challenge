//
//  MainViewController.swift
//  HomeControl
//
//  Created by Rafael M. A. da Silva on 12/10/15.
//  Copyright © 2015 venturus. All rights reserved.
//

import UIKit

class MainViewController:UIViewController{
    
    @IBOutlet weak var lampSwitch: UISwitch!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureImage: UIImageView!
    
    override func viewDidLoad() {
        self.lampSwitch.addTarget(self, action: Selector("switchLamp"), forControlEvents: UIControlEvents.ValueChanged)
        self.temperatureImage.userInteractionEnabled=true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("fetchTemperature"))
        self.temperatureImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func fetchTemperature() {
        print("22.3 °C")
    }
    
    func switchLamp() {
        print("Changing state")
    }
    
    func fetchLampState() {
    
    }
    
}
