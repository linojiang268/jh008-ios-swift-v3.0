//
//  PersonalInfoPickerCell.swift
//  Jike
//
//  Created by Iosmac on 15/8/9.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit


class PersonalInfoPickerCell: UITableViewCell {

    var titleView:UILabel!
    var selectedView:UIImageView!

    let padding = UISettings.common_table_padding

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = Color.common_text_bg_color

        titleView = UiUtils.createCommonLabelWithAlign(padding*3, y: padding*2, width: UiUtils.getBaseWidth()-padding*2,
                                                       fontSize: 14, align: NSTextAlignment.Left, title: "")
        titleView.textColor = Color.common_text_color_black

        titleView.center.y = self.frame.height/2

        selectedView = UIImageView(frame: CGRectMake(self.frame.width-UISettings.personal_info_item_height, 0,
                                   UISettings.personal_info_item_height, UISettings.personal_info_item_height))
        selectedView.contentMode = UIViewContentMode.Center
        selectedView.image = UIImage(named: "mine_edit_personal_info_selected_bg_normal")
        selectedView.hidden = true

        self.addSubview(titleView)
        self.addSubview(selectedView)

        titleView.userInteractionEnabled = false
        self.sendSubviewToBack(titleView)
    }

    func setData(data:DataIdValuePair) {
        titleView.text = data.value
        selectedView.hidden = data.id == 0

        selectedView.frame.origin.x = UiUtils.getBaseWidth()-UISettings.personal_info_item_height
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}