//
//  ParentPicker.swift
//  Jike
//
//  Created by Iosmac on 15/6/9.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import UIKit
import Foundation

protocol CommonPickerPickedDelegate {

    func selectedData(id1:Int, value1:String, id2:Int, value2:String)
}

protocol ParentPickerDelegate {

    func getTitleForShow(index:Int, component:Int) -> String
    func getNumOfComponent() -> Int
    func getRowForComponent(component:Int) -> Int

    func selctedRow(index1:Int, index2:Int)
}

class ParentPicker: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    var picker:UIPickerView!

    let baseWidth = UiUtils.getBaseWidth()
    let baseHeight = UiUtils.getBaseHeight()

    var bottomParentView:UIView!

    var delegate:ParentPickerDelegate!
    var dataPickedDelegate:CommonPickerPickedDelegate!

    var parentVC:UIViewController!

    let padding = UISettings.common_table_padding

    init(parentVC:UIViewController) {

        super.init(frame: CGRectMake(0, 0, baseWidth, baseHeight))
        self.backgroundColor = Color.none

        self.parentVC = parentVC

        picker = UIPickerView(frame: CGRectMake(0, 0, baseWidth, baseWidth/1.5))
        picker.backgroundColor = Color.common_picker_bg_color

        let buttonWidth = picker.frame.height/4
        let buttonHeight = picker.frame.height/6

        let btnCancel = UIButton(frame: CGRectMake(0, 0, buttonWidth, buttonHeight))
        let btnOk = UIButton(frame: CGRectMake(baseWidth-buttonWidth-padding, padding, buttonWidth, buttonHeight))

        btnOk.setTitleColor(Color.styleColor, forState: UIControlState.Normal)
        btnOk.titleLabel?.font = UISettings.getFont(UISettings.common_label_content_font)
        btnOk.layer.cornerRadius = UISettings.common_corner_size
        btnOk.layer.borderColor = Color.styleColor.CGColor
        btnOk.layer.borderWidth = 1

        btnCancel.setTitle("取消", forState: UIControlState.Normal)
        btnOk.setTitle("确定", forState: UIControlState.Normal)

        btnCancel.setTitleColor(Color.common_black_bg, forState: UIControlState.Normal)
        //btnOk.setTitleColor(Color.common_black_bg, forState: UIControlState.Normal)

        btnCancel.addTarget(self, action: "btnCancelClicked", forControlEvents: UIControlEvents.TouchUpInside)
        btnOk.addTarget(self, action: "btnOkClicked", forControlEvents: UIControlEvents.TouchUpInside)

        bottomParentView = UIView(frame: CGRectMake(0, baseHeight-picker.frame.height,
                                                    baseWidth, picker.frame.height))

        bottomParentView.addSubview(picker)
//        bottomParentView.addSubview(btnCancel)
        bottomParentView.addSubview(btnOk)
        bottomParentView.bringSubviewToFront(btnOk)
//        bottomParentView.backgroundColor = Color.user_page_bg_color

        self.addSubview(bottomParentView)

        self.userInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "ousideClicked"))
    }

    func ousideClicked() {
        self.removeFromSuperview()
    }

    func show() {
        self.parentVC.view.addSubview(self)
        setDataBack()
    }

    func initData(del:ParentPickerDelegate, selectedRow:Int) {
        initData(del, selectedRow: selectedRow, componentRow: 0)
    }

    func initData(del:ParentPickerDelegate, selectedRow:Int, componentRow:Int) {
        self.delegate = del

        picker.dataSource = self
        picker.delegate = self

        picker.selectRow(selectedRow, inComponent: componentRow, animated: false)

        picker.reloadAllComponents()

    }

    func btnCancelClicked() {
        self.removeFromSuperview()
    }

    func btnOkClicked() {
        LogUtils.log("btnOkClicked()")

        self.removeFromSuperview()
    }

    func setDataBack() {
        if(self.delegate.getNumOfComponent()>1) {
            self.delegate.selctedRow(picker.selectedRowInComponent(0), index2: picker.selectedRowInComponent(1))
        }
        else {
            self.delegate.selctedRow(picker.selectedRowInComponent(0), index2: picker.selectedRowInComponent(0))
        }
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        LogUtils.log("didSelectRow:row=\(row), component=\(component)")
        
        if(component==0 && self.delegate.getNumOfComponent()>1) {
            pickerView.selectRow(0, inComponent: 1, animated: false)
            pickerView.reloadComponent(1)
        }

        setDataBack()
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return self.delegate.getTitleForShow(row, component:component)
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return self.delegate.getNumOfComponent()
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return self.delegate.getRowForComponent(component)
    }

    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }

    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return baseWidth/CGFloat(self.delegate.getNumOfComponent())
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}