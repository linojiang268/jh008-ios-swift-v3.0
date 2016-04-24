//
//  CountryUniversityCell.swift
//  Jike
//
//  Created by Iosmac on 15/6/9.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class CountryUniversityCell: UITableViewCell {

    enum CellType {
        case Country
        case University
    }

    var titleView:UILabel!
    var titleChnView:UILabel!

    let padding = UISettings.common_table_padding
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = Color.common_text_bg_color

        titleView = UiUtils.createCommonLabelWithAlign(padding*2, y: padding, width: UiUtils.getBaseWidth()-padding*2,
                                                       fontSize: 13, align: NSTextAlignment.Left, title: "")
        titleView.textColor = Color.common_text_color_black


        titleChnView = UiUtils.createCommonLabelWithAlign(padding*2, y: titleView.frame.maxY+padding,
                                                          width: UiUtils.getBaseWidth()-padding*2,
                                                          fontSize: 12, align: NSTextAlignment.Left, title: "")
        titleChnView.textColor = Color.common_text_color_gray
        titleChnView.hidden = true


        self.addSubview(titleView)
        self.addSubview(titleChnView)
    }

    func setData(data:DataIdValuePair, cellType:CellType) {

        titleView.text = data.value
        titleChnView.text = data.otherValue

        UiUtils.resetViewHeightByChar(titleView, text: titleView.text!, viewWidth: titleView.frame.width,
                                      fontSize: titleView.font.pointSize)

        if(cellType == CellType.Country) {
            titleView.center.y = UISettings.country_city_item_height/2
            titleChnView.hidden = true
        }
        else {
            titleView.frame.origin.y = padding
            titleChnView.hidden = false
    
            UiUtils.resetViewHeightByChar(titleChnView,text: (titleChnView.text != nil ? titleChnView.text!:"N/A"),
                viewWidth: titleChnView.frame.width,
                                          fontSize: titleChnView.font.pointSize)

            titleChnView.frame.origin.y = titleView.frame.maxY + padding/2
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}