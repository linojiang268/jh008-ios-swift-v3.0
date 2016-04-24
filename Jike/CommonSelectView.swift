//
//  CommonSelectView.swift
//  Jike
//
//  Created by Iosmac on 15/8/9.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class CommonSelectView: UIView {

    private var titleLabel:UITextField!

    private var selectedId:Int?

    init(x:CGFloat, y:CGFloat, holder:String) {
        super.init(frame: CGRectMake(x, y, UiUtils.getBaseWidth(), UISettings.common_select_view_height))

        self.backgroundColor = Color.common_text_bg_color

        titleLabel = UITextField(frame: CGRectMake(UISettings.common_table_padding*2, 0,
                                 self.frame.width-UISettings.common_table_padding*2, self.frame.height))
        titleLabel.enabled = false
        titleLabel.placeholder = holder
        titleLabel.font = UISettings.getFont(UISettings.title_view_title_text_size)
        titleLabel.textColor = Color.common_text_color_black

        let arrowImg = UIImage(named: "common_arrow_right_icon_img")!
        let arrowV = UIImageView(frame: CGRectMake(self.frame.width-arrowImg.size.width-UISettings.common_table_padding*2, 0,
                                                   arrowImg.size.width, self.frame.height))
        arrowV.contentMode = UIViewContentMode.Center
        arrowV.image = arrowImg

        self.addSubview(titleLabel)
        self.addSubview(arrowV)
    }

    func setTitleValue(title:String?, id:Int?) {
        self.titleLabel.text = title
        self.selectedId = id
    }

    func getSelectedId() ->Int? {
        return selectedId
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}