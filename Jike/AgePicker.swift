

import UIKit
import Foundation



class AgePicker: ParentPicker, ParentPickerDelegate {


    var ageList:NSArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("age.plist", ofType: nil)!)!

    init(parentVC:UIViewController, existData:Int?) {
        super.init(parentVC: parentVC)

        if(existData != nil && existData! >= 15) {
            for index in 0...(ageList.count-1) {
                let age: AnyObject = ageList[index]
                if("\(age)" == "\(existData!)") {
                    initData(self, selectedRow: index)
                    break
                }
            }
        }
        else {
            initData(self, selectedRow: 16)
        }
    }

    override init(parentVC:UIViewController) {
        super.init(parentVC: parentVC)

        initData(self, selectedRow: 16)
    }

    func getTitleForShow(index:Int, component:Int) -> String {
        return "\(ageList[index])岁"
    }

    func getNumOfComponent() -> Int {
        return 1
    }

    func getRowForComponent(component:Int) -> Int {
        return ageList.count
    }

    func selctedRow(index1:Int, index2:Int) {
        LogUtils.log("selctedRow():index1\(index1), index2=\(index2)")
        if(dataPickedDelegate != nil) {
            dataPickedDelegate.selectedData(Int((ageList[index1] as! String))!, value1: "\(ageList[index1])岁", id2: 0, value2: "")
        }
    }



    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}