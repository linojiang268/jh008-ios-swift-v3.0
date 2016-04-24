//
//  GenderPicker.swift
//  Jike
//
//  Created by Iosmac on 15/6/11.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import UIKit
import Foundation


class GenderPicker: ParentPicker, ParentPickerDelegate {


    var genderList:NSArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("gender.plist", ofType: nil)!)!

    init(parentVC:UIViewController, existData:Int?) {
        super.init(parentVC: parentVC)

        if(existData != nil  && existData! >= 0) {
            for index in 0...(genderList.count-1) {
                let gender = genderList[index] as! NSDictionary
                let genderId = gender.valueForKey("id") as! Int
                if(genderId == existData) {
                    initData(self, selectedRow: index)
                    break
                }
            }
        }
        else {
            initData(self, selectedRow: 0)
        }
    }

    override init(parentVC:UIViewController) {
        super.init(parentVC: parentVC)

        initData(self, selectedRow: 0)
    }

    func getTitleForShow(index:Int, component:Int) -> String {
        return (genderList[index] as! NSDictionary).valueForKey("value") as! String
    }

    func getNumOfComponent() -> Int {
        return 1
    }

    func getRowForComponent(component:Int) -> Int {
        return 2
    }

    func selctedRow(index1:Int, index2:Int) {
        LogUtils.log("selctedRow():index1=\(index1), index2=\(index2)")
        if(dataPickedDelegate != nil) {
            dataPickedDelegate.selectedData((genderList[index1] as! NSDictionary).valueForKey("id") as! Int,
                                            value1: (genderList[index1] as! NSDictionary).valueForKey("value") as! String,
                                            id2: 0, value2: "")
        }
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}