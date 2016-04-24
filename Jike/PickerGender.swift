//
//  PickerGender.swift
//  Gather4
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit


class PickerGender: BasePicker {
    
    private var maleCell:PickerGenderCell!
    private var femaleCell:PickerGenderCell!
    
    private var cancelCell:CommonClickableText!
    
    
    override init(pickerKey:String, parentView: UIView, pickerDel: PickerDelegate, selectedData: DataSelectedItem?) {
        super.init(pickerKey: pickerKey, parentView: parentView, pickerDel: pickerDel, selectedData: selectedData)
        
        let baseY = parentView.frame.height-UISettings.common_select_view_height*3
        
        maleCell = PickerGenderCell(y: baseY, width: parentView.frame.width,
                                    selectData: DataSelectedItem(id: DataSettings.getGenderCodeByEnum(DataSettings.Gender.Male), value:"男"))
        
        femaleCell = PickerGenderCell(y: maleCell.frame.maxY, width: parentView.frame.width,
                                      selectData: DataSelectedItem(id: DataSettings.getGenderCodeByEnum(DataSettings.Gender.Female), value:"女"))
        
        cancelCell = CommonClickableText(x: 0, y: femaleCell.frame.maxY, title: "取消")
        cancelCell.frame = CGRectMake(0, femaleCell.frame.maxY, parentView.frame.width, UISettings.common_select_view_height)
        
        maleCell.backgroundColor = Color.picker_bg_color
        femaleCell.backgroundColor = Color.picker_bg_color
        cancelCell.backgroundColor = Color.picker_bg_color
        
        maleCell.setDataPairSelected(selectedData)
        femaleCell.setDataPairSelected(selectedData)
        
        maleCell.userInteractionEnabled = true
        maleCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "maleCellClicked"))
        
        femaleCell.userInteractionEnabled = true
        femaleCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "femaleCellClicked"))
        
        cancelCell.userInteractionEnabled = true
        cancelCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "cancelClicked"))
        
        self.addSubview(maleCell)
        self.addSubview(femaleCell)
        self.addSubview(cancelCell)
        
    }
    
    func maleCellClicked() {
        maleCell.setSelect(true)
        femaleCell.setSelect(false)
        
        self.mySelectedData = maleCell.getSelectData()
        
        delayClose()
    }
    
    func femaleCellClicked() {
        maleCell.setSelect(false)
        femaleCell.setSelect(true)
        
        self.mySelectedData = femaleCell.getSelectData()
        
        delayClose()
    }
    
    func cancelClicked() {
        self.removeFromSuperview()
    }
    
    private func delayClose() {
        let delay = 0.2 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.pickerDel.pickerSelected(self.pickerKey, selectedData: self.mySelectedData)
            self.removeFromSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}