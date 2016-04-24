//
//  BodyPicker.swift
//  Jike
//
//  Created by Iosmac on 15/6/9.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class BodyHeightPicker :ParentPicker,ParentPickerDelegate {

    var heightList:NSMutableArray = NSMutableArray()


    convenience init(parentVC:UIViewController, existData:Int?) {
        self.init(parentVC: parentVC)

        if(existData != nil && existData! >= 0) {
            for index in 0...(heightList.count-1) {
                let height = heightList[index] as! Int
                if(height == existData) {
                    initData(self, selectedRow: index)
                    break
                }
            }
        }
    }

    override init(parentVC:UIViewController) {
        super.init(parentVC: parentVC)

        for index in 155...220 {
            heightList.addObject(index)
        }

        initData(self, selectedRow: 20)
    }

    func getTitleForShow(index:Int, component:Int) -> String {

        return "\(heightList[index]) cm"
    }

    func getNumOfComponent() -> Int {
        return 1
    }

    func getRowForComponent(component:Int) -> Int {
        return heightList.count
    }

    func selctedRow(index1:Int, index2:Int) {
        dataPickedDelegate.selectedData(heightList[index1] as! Int, value1: "\(heightList[index1]) cm", id2: 0, value2: "")
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}