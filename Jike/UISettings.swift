//
//  UISettings.swift
//  Jike
//
//  Created by Iosmac on 15/5/13.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

struct UISettings {
    
    static let common_padding:CGFloat = 8
    static let common_input_view_height:CGFloat = 40
    static let common_button_view_height:CGFloat = 40
    static let common_label_view_height:CGFloat = 40
    static let common_select_view_height:CGFloat = 40
    
    static let common_font_size_middle:CGFloat = 14

    //获取font的函数，传入字号，返回字体.全部统一从这里取方便修改字体
    static func getFont(fontSize: CGFloat) -> UIFont {
        //let heiFont = UIFont(name: "AppleSDGothicNeo-Medium", size: fontSize)
        //LogUtils.log("getFont():heiFont=\(heiFont)")
        
        return UIFont.systemFontOfSize(fontSize)
    }

    //黑体的获取函数
    static func getFontBold(fontSize: CGFloat) -> UIFont {
        let heiFont = UIFont(name: "Helvetica-Bold", size: fontSize)//STHeitiSC-Medium
        return heiFont != nil ? heiFont! : UIFont.systemFontOfSize(fontSize)
    }

    static let bottom_tab_bar_height:CGFloat = 49//底部tab栏的高度

    static let share_pic_scroll_segment_height:CGFloat = 36//晒图的话题界面，顶部排序按钮栏的高度

    static let emoji_panel_view_height:CGFloat = 256

    static let common_personal_info_corner_size:CGFloat = 1//个人信息里面的兴趣 交友要求等的item标签的圆角半径

    static let share_pic_cell_sentence_font_size:CGFloat = 15//晒图子view分项的那句话的size
    static let share_pic_cell_img_height:CGFloat = 320//晒图列表子view中图片空间的高度
    static let share_pic_cell_base_height:CGFloat = 62+320+77+20//晒图列表子view的基准高度，即没有任何填充内容和计算的时候的初始高度
    static let share_pic_cell_bottom_height_without_share_sen:CGFloat = 77

    static let common_status_bar_height:CGFloat = 20//顶部系统状态栏的高度

    static let share_pic_black_fone_size:CGFloat = 14
    static let share_pic_gray_fone_size:CGFloat = 13

    static let common_phone_height_4s:CGFloat = 480
    static let common_phone_height_5s:CGFloat = 568
    static let common_phone_height_6:CGFloat = 667

    static let common_key_board_height:CGFloat = 252//键盘的默认高度
    
    static let title_view_title_text_size:CGFloat = 16//页面标题文字的大小
    
    static let common_table_padding:CGFloat = 5

    static let common_user_page_padding:CGFloat = 10

    static let user_page_field_height:CGFloat = 46
    
    static let chat_list_item_height:CGFloat = 68//会话列表子view的高度

    static let chat_msg_list_item_height:CGFloat = 56//聊天界面的子view的基准高度
    
    static let common_corner_size:CGFloat = 4//大部分界面中存在圆角view的圆角半径

    static let common_title_height:CGFloat = 64//顶部标题栏的高度

    static let common_label_title_font:CGFloat = 14
    static let common_label_content_font:CGFloat = 14

    static let common_line_height:CGFloat = 0.5

    static let country_city_item_height:CGFloat = 62//国家城市界面子view的高度

    static let personal_info_item_height:CGFloat = 42

}
