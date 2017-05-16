//
//  BLEHelper.swift
//  CBExercise
//
//  Created by Federico Frias on 3/19/17.
//  Copyright © 2017 ffrias. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLEHelper{
    static let sharedInstance = BLEHelper()
    var centralManager:CBCentralManager!
    var bleHandler:BLEHandler
    
    private init(){
        self.bleHandler = BLEHandler()
        self.centralManager = CBCentralManager(delegate: self.bleHandler, queue: nil)
    }
}

class BLEHandler:NSObject, CBCentralManagerDelegate{
    override init(){
        super.init()
    }
    
    static let bleNotification = "bleNotification"
    
    func centralManagerDidUpdateState(central: CBCentralManager){
        print("CentralManager is initialized")
        
        switch central.state{
        case .Unsupported:
            print("Bluetooth is unsopported.")
        case .Unauthorized:
            print("The app is not authorized to use Bluetooth low energy.")
        case .Unknown:
            print("Bluetooth is unknown.")
        case .Resetting:
            print("Bluetooth is resetting.")
        case .PoweredOff:
            print("Bluetooth is currently powered off.")
        case .PoweredOn:
            print("Bluetooth is currently powered on and available to use.")
            print("Start device scanning...")
            central.scanForPeripheralsWithServices(nil, options: nil)
        }
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        
        if peripheral.name != nil {
            
            print("Device found: " + peripheral.name!)
            print("RSSI: " + String(RSSI))
            
            if (RSSI.integerValue < -40 && RSSI.integerValue > -50) {
                print("El device esta a aprox 50cm...")
                
                let peripheralInfo:[String:String] = ["peripheral": peripheral.name!]
                NSNotificationCenter.defaultCenter().postNotificationName("bleNotification", object: nil, userInfo: peripheralInfo)
            }
        }
    }
}