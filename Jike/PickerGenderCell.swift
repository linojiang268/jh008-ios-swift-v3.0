//
//  PickerGenderCell.swift
//  Gather4
//
//  Created by apple on 15/11/6.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit


class PickerGenderCell:UIView {
    
    private var titleV:CommonLabelView!
    private var selectIconV:UIImageView!
    private var selectData:DataSelectedItem?
    
    
    init(y:CGFloat, width:CGFloat, selectData:DataSelectedItem?) {
        super.init(frame: CGRectMake(0, y, width, UISettings.common_select_view_height))
        
        self.selectData = selectData
        
        titleV = CommonLabelView(x: 0, y: 0, text: selectData?.value)
        selectIconV = UIImageView(frame: CGRectMake(width-UISettings.common_select_view_height, 0,
                                                    UISettings.common_select_view_height, UISettings.common_select_view_height))
        selectIconV.contentMode = UIViewContentMode.Center
        
        self.addSubview(titleV)
        self.addSubview(selectIconV)
    }
    
    func getSelectData() -> DataSelectedItem? {
        return self.selectData
    }
    
    func setSelect(isSelected:Bool) {
        selectIconV.image = isSelected ? UIImage(named: "") : UIImage(named: "")
    }
    
    func setDataPairSelected(selectedData:DataSelectedItem?) -> Void {
        setSelect(selectedData?.id != nil && selectedData?.id == self.selectData?.id)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}