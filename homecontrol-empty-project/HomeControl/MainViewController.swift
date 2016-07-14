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
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("fetchLampState"), userInfo: nil, repeats: true)
    }
    
    func fetchTemperature() {
        /*
        Notar abaixo que a funcao lamba pode ser passada como parametro fora do () da chamada da funcao.
        Isto e um acucar sintatico para ficar mais legivel. O closure poderia ter sido passado dentro do (),
        quando se passa apenas um parametro, como e o caso, ele pode ficar fora.
        */
        IOTService.sharedInstance.fetchTemperature() { (statuscode, error, homeModel) -> () in
            print("Temperature ready to be displayed")
            print("Temperature:  \(homeModel!.temperatureValue) °C")
        }
        print("Asked for temperature")
    }
    
    func switchLamp() {
        print("Changing state")
    }
    
    func fetchLampState() {
//        print("Fetch lamp state")
    }
    
}
