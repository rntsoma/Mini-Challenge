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
    var homeInfoList = Array<HomeModel>()
    
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
        Se o closure for o ultimo parametro, ele pode ser passado fora dos ()
        */
        IOTService.sharedInstance.fetchTemperature() { (statuscode, error, homeModel) -> () in
            print("Temperature ready to be displayed")
            print("Temperature:  \(homeModel!.temperatureValue) °C")
            self.temperatureLabel.text="Temp: \(round((homeModel!.temperatureValue*100)/100)) °C"
            self.homeInfoList.append(homeModel!)
        }
        print("Asked for temperature")
    }
    
    func switchLamp() {
        let oldState=self.lampSwitch.on
        IOTService.sharedInstance.switchLamp(self.lampSwitch.on) { (statusCode:Int, error:NSError?) -> () in
            if let _ = error{
                self.lampSwitch.setOn(oldState, animated: true)
            }
            print("Lamp switch response")
        }
        print("Request switch lamp...")
    }
    
    func fetchLampState() {
//        print("Fetch lamp state")
        IOTService.sharedInstance.fetchLampState { (statusCode, error) -> () in
            print(statusCode)
            if(statusCode == 200){
                self.lampSwitch.setOn(true, animated: true)
            }else{
                self.lampSwitch.setOn(false, animated: true)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let historyTableViewController = segue.destinationViewController as! HistoryTableViewController
        historyTableViewController.tableViewHomeInfoArray = self.homeInfoList
    }
    
}
