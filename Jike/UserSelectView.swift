//
//  UserSelectView.swift
//  Gather4
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

protocol UserSelectViewDelegate {
    func selectClicked(viewKey:String, defaultData:DataSelectedItem?)
}

class UserSelectView: UIView {
    
    private var titleV:CommonLabelView!
    private var valueV:CommonLabelView!
    
    private var viewKey:String!
    
    private var selectedValue:DataSelectedItem?
    private var delegate:UserSelectViewDelegate!
    
    
    init(viewKey:String, x: CGFloat, y:CGFloat, width:CGFloat, title:String?, defaultValue:DataSelectedItem?, delegate: UserSelectViewDelegate) {
        super.init(frame: CGRectMake(x, y, width, UISettings.common_select_view_height))
        
        self.viewKey = viewKey
        self.selectedValue = defaultValue
        self.delegate = delegate
        
        self.titleV = CommonLabelView(x: UISettings.common_padding, y: 0, text: title)
        self.valueV = CommonLabelView(x: frame.width/4, y: 0, text: defaultValue?.value)
        
        self.titleV.textColor = Color.common_text_color_gray
        
        self.addSubview(self.titleV)
        self.addSubview(self.valueV)
        
        self.userInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "selectClicked"))
        
        self.backgroundColor = Color.white
    }
    
    func selectClicked() {
        self.delegate.selectClicked(self.viewKey, defaultData:self.selectedValue)
    }
    
    func resetSelectedValue(selectedValue:DataSelectedItem?) {
        self.selectedValue = selectedValue
        self.valueV.text = selectedValue?.value
    }
    
    func getIdForNetRequestParam() -> Int {
        if(selectedValue?.id != nil) {
            return selectedValue!.id!
        }
        return 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}