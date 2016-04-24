//
//  NoContentView.swift
//  Jike
//
//  Created by Iosmac on 15/7/19.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class NoContentView: UIView {


    var paddingTop:CGFloat = UISettings.common_title_height
    let baseWidth = UiUtils.getBaseWidth()

    var titleView: UILabel!
    var catView: UIImageView!

    init(top:CGFloat?) {
        super.init(frame: CGRectMake(0, 0, baseWidth, UiUtils.getBaseHeight()))

        if(top != nil) {
            paddingTop = paddingTop + top!
        }

        titleView = UiUtils.createCommonLabelWithAlign(0, y: UISettings.common_title_height, width: baseWidth,
                            fontSize: UISettings.title_view_title_text_size, align: NSTextAlignment.Center, title: "")
        titleView.textColor = Color.common_text_color_black

        catView = UIImageView(image: UIImage(named: "common_no_content_cat_img"))
        catView.center.x = baseWidth/2
        catView.center.y = UiUtils.getBaseHeight()/2 + paddingTop/2

        self.addSubview(titleView)
        self.addSubview(catView)
    }

    func show(tips:String, vc:UIView) {
        self.titleView.text = tips
        UiUtils.resetViewHeightByChar(titleView, text: titleView.text!, viewWidth: titleView.frame.width,
                                      fontSize: titleView.font.pointSize)
        self.titleView.center.y = catView.frame.minY/2

        vc.addSubview(self)
        vc.sendSubviewToBack(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}