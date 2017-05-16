//
//  ViewController.swift
//  CBExercise
//
//  Created by Federico Frias on 3/19/17.
//  Copyright © 2017 ffrias. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var deviceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        BLEHelper.sharedInstance
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.bluetoothDiscovered), name: BLEHandler.bleNotification, object: nil)
    }
    
    func bluetoothDiscovered(notification:NSNotification){
        let device = (notification.userInfo!["peripheral"] as! String)
        deviceLabel.text = "Your device is: " + device
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}