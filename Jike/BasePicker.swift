//
//  BasePicker.swift
//  Gather4
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

protocol PickerDelegate {
    func pickerSelected(pickerKey:String, selectedData:DataSelectedItem?)
}

class BasePicker: UIView {
    
    internal var mySelectedData:DataSelectedItem?
    
    private var parentView:UIView!
    
    internal var pickerDel:PickerDelegate!
    
    internal var pickerKey:String!
    
    init(pickerKey:String, parentView:UIView, pickerDel:PickerDelegate, selectedData: DataSelectedItem?) {
        super.init(frame: CGRectMake(0, 0, parentView.frame.width, parentView.frame.height))
        self.pickerDel = pickerDel
        self.parentView = parentView
        self.mySelectedData = selectedData
        self.pickerKey = pickerKey
        
        self.userInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "pickerOutSideClicked"))
        
        self.backgroundColor = Color.red
    }
    
    func pickerOutSideClicked() {
        self.removeFromSuperview()
    }
    
    func showPicker() {
        self.parentView.addSubview(self)
    }
    
    func setSelectedData(data:DataSelectedItem?) {
        self.mySelectedData = data
    }
    
    func getSelectedData() -> DataSelectedItem? {
        return self.mySelectedData
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}