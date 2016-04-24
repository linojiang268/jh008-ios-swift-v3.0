//
//  PickerBirthday.swift
//  Gather4
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit


class PickerBirthday: BasePicker {
    
    private var datePicker:UIDatePicker!
    
    
    override init(pickerKey: String, parentView: UIView, pickerDel: PickerDelegate, selectedData: DataSelectedItem?) {
        super.init(pickerKey: pickerKey, parentView: parentView, pickerDel: pickerDel, selectedData: selectedData)
        
        datePicker = UIDatePicker(frame: CGRectMake(0, self.frame.height-300, parentView.frame.width, 300))
        datePicker.date = NSDate(timeIntervalSinceNow: -60*60*24*365*30)
        datePicker.minimumDate = NSDate(timeIntervalSinceNow: -60*60*24*365*65)
        datePicker.maximumDate = NSDate(timeIntervalSinceNow: 0)
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.backgroundColor = Color.picker_bg_color
        
        datePicker.addTarget(self, action: "dateSelected", forControlEvents: UIControlEvents.ValueChanged)
        
        self.addSubview(datePicker)
    }
    
    func dateSelected() {
        self.pickerDel.pickerSelected(self.pickerKey, selectedData: self.mySelectedData)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}