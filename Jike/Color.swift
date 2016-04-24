//
//  Color.swift
//  Jike
//
//  Created by ios on 15-4-23.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

struct Color {
    
    static let picker_bg_color = UIColor.whiteColor()
    
    static let interest_color_red = red
    static let interest_color_yellow = common_yellow_color
    static let interest_color_green = styleColor
    static let interest_color_blue = styleColor
    static let interest_color_black = common_text_color_black
    
    static let none = UIColor.clearColor()

    static let common_page_bg_color = UiUtils.getColorFromRGB(246, g:245, b:241, alpha:1)//界面的背景颜色

    static let common_text_color_black = UIColor.blackColor()//偏黑的文字颜色
    static let common_text_color_gray = UiUtils.getColorFromRGB(124, g:124, b:124, alpha:1)//偏灰的字体颜色

    static let common_line_color = UIColor.lightGrayColor().colorWithAlphaComponent(0.5)//所有的分割线的颜色

    static let common_text_bg_color = UIColor.whiteColor()//文字的背景，都是白色

    static let common_black_bg = UIColor.blackColor().colorWithAlphaComponent(0.76)

    static let common_yellow_color = UiUtils.getColorFromRGB(255, g:186, b:52, alpha:1)

    static let common_picker_bg_color = UiUtils.getColorFromRGB(248, g:248, b:248, alpha:1)

    static let styleColor = UiUtils.getColorFromRGB(39, g:208, b:215, alpha:1)//主题色

    static let personalInfoMyPointColor = UiUtils.getColorFromRGB(255, g:192, b:94, alpha:1)//我的标签的背景
    static let personalInfoMakeFriendsRequirementColor = UiUtils.getColorFromRGB(116, g:184, b:242, alpha:1)//交友要求背景色
    static let personalInfoMyHobbyColor = UiUtils.getColorFromRGB(255, g:160, b:169, alpha:1)//兴趣爱好背景色

    static let titleTextColor = UIColor.blackColor().colorWithAlphaComponent(0.8)

    static let red = UIColor.redColor()

    static let white = UIColor.whiteColor()

    static let white_line_color = UIColor.whiteColor().colorWithAlphaComponent(0.6)

    static let gray = UIColor.lightGrayColor()
}