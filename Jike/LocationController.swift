//
//  LocationControll.swift
//  Jike
//
//  Created by Iosmac on 15/6/8.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationControllDelegate:NSObjectProtocol
{
    //定位完成
    func locateFinished(lat:Double,lon:Double)
    //定位失败
    func loacteFaild()
}

class LocationController: BaseController, CLLocationManagerDelegate {

    var man:CLLocationManager = CLLocationManager()
    var locBack:(address:String)->Void
    weak var locateDelegate:LocationControllDelegate!

    init(locBack:(address:String)->Void) {
        self.locBack = locBack

        super.init()
        LogUtils.log("LocationControll init")
        if #available(iOS 8.0, *)
        {
            man.requestAlwaysAuthorization()
            LogUtils.log("requestAlwaysAuthorization()")
        }
    }

    func getLocation() {
        LogUtils.log("getLocation():\(CLLocationManager.locationServicesEnabled())")

        if(CLLocationManager.locationServicesEnabled()) {

            man.delegate = self
            man.desiredAccuracy = kCLLocationAccuracyBest
            man.distanceFilter = CLLocationDistance(1000)
            man.startUpdatingLocation()

            LogUtils.log("startUpdatingLocation()")
        }
        else
        {
            //定位未开启
            self.locateDelegate.loacteFaild()
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        manager.stopUpdatingLocation()

        let oneLoc = locations.last
        
        if (oneLoc == nil)
        {
            return
        }
        
        self.locateDelegate.locateFinished(oneLoc!.coordinate.latitude, lon: oneLoc!.coordinate.longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(oneLoc!, completionHandler: { (places:[CLPlacemark]?, error:NSError?) -> Void in
            if(places != nil) {
                for p in places! {
                    let placeMask = p
                    var address = placeMask.addressDictionary as! [String:AnyObject]
                    LogUtils.log("address=\(address)")

                    var myAddress = ""
                    let country = address["Country"] as? NSString
                    if country != nil {
                        myAddress = myAddress+(country as! String)
                    }

                    if let state = address["State"] as? NSString {
                        myAddress = myAddress+" "+(state as String)
                    }

                    let city = address["City"] as? NSString
                    if city != nil {
                        myAddress = myAddress+" "+(city as! String)
                    }
                    if(address["CountryCode"] as! String == "CN")
                    {
                        
                       self.locBack(address: "")
                    }
                    else
                    {
                        self.locBack(address: myAddress)
                    }

                    var detailAddress = ""

                    if let subLocality = address["SubLocality"] as? NSString {
                        detailAddress = detailAddress+(subLocality as String)
                    }

                    if let street = address["Street"] as? NSString {
                        detailAddress = detailAddress+(street as String)
                    }
                    

                    break
                }
            }

        })

        LogUtils.log("locationManager():didUpdateLocations:")
    }


    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        LogUtils.log("locationManager():didFailWithError=\(error)")
        self.locateDelegate.loacteFaild()
    }


}