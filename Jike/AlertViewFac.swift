//
//  AlertViewUtils.swift
//  Jike
//
//  Created by Iosmac on 15/7/1.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit



class AlertViewFac: NSObject, UIAlertViewDelegate {

    var buttonClicked:(isOk:Bool)->Void

    init(buttonClicked:(isOk:Bool)->Void) {
        self.buttonClicked = buttonClicked
    }

    func showAlert(message:String) {
        let alert = UIAlertView(title: "提示", message: message, delegate: self, cancelButtonTitle: "确定",
                                otherButtonTitles: "取消")
        alert.show()
    }

    func showAlert(title:String,message:String,cancelButtonTitle:String,otherButtonTitle:String) {
        let alert = UIAlertView(title:title, message: message, delegate: self, cancelButtonTitle:cancelButtonTitle,
            otherButtonTitles: otherButtonTitle)
        alert.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        LogUtils.log("AlertViewFac: buttonIndex=\(buttonIndex)")
        self.buttonClicked(isOk: buttonIndex==0)
    }
    
    static func showAlertWithNoOperation(message:String) {
        let alert = UIAlertView(title: "提示", message: message, delegate: nil, cancelButtonTitle: "确定")
        alert.show()
    }
}