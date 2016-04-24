//
//  ConstellationPicker.swift
//  Jike
//
//  Created by Iosmac on 15/6/18.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class ConstellationPicker :ParentPicker,ParentPickerDelegate {

    var constellationList:NSArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("constellation.plist",
                                            ofType: nil)!)!

    init(parentVC:UIViewController, existData:String?) {
        super.init(parentVC: parentVC)

        if(existData != nil && (existData!).characters.count>0) {
            for index in 0...(constellationList.count-1) {
                let con: AnyObject = constellationList[index]
                if("\(con)" == existData) {
                    initData(self, selectedRow: index)
                    break
                }
            }
        }
        else {
            initData(self, selectedRow: 2)
        }
    }

    override init(parentVC:UIViewController) {
        super.init(parentVC: parentVC)

        initData(self, selectedRow: 2)
    }

    func getTitleForShow(index:Int, component:Int) -> String {

        return constellationList[index] as! String
    }

    func getNumOfComponent() -> Int {
        return 1
    }

    func getRowForComponent(component:Int) -> Int {
        return constellationList.count
    }

    func selctedRow(index1:Int, index2:Int) {
        dataPickedDelegate.selectedData(index1, value1: constellationList[index1] as! String, id2: 0, value2: "")
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}