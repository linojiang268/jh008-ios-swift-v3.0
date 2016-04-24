//
//  DialogUtils.swift
//  Jike
//
//  Created by Iosmac on 15/6/28.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit



class DialogUtils {

    var alertV:AlertViewFac!

    func getDlgOkCancel(vc:UIViewController, msg:String, buttonClicked:(isOk:Bool)->Void) {

        if #available(iOS 8.0, *)
        {
            let alert = UIAlertController(title: "提示", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "确定", style: .Default, handler: { (action: UIAlertAction) in
                buttonClicked(isOk: true)
            }))

            alert.addAction(UIAlertAction(title: "取消", style: .Default, handler: { (action: UIAlertAction) in
                buttonClicked(isOk: false)
            }))

            vc.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            alertV = AlertViewFac(buttonClicked: { [unowned self](isOk) -> Void in
                buttonClicked(isOk: isOk)
                self.alertV = nil
            })
            alertV.showAlert(msg)
        }
    }



}