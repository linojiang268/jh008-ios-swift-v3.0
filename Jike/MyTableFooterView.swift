//
//  MyTableFooterView.swift
//  Gather4
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit


class MyTableFooterView:UIView {
    
    
    enum Status {
        case LoadingMore
        case NoMoreData
        case ClickToLoadMore
    }
    
    let padding = UISettings.common_table_padding
    var indicator:UIActivityIndicatorView!
    var titleView:UILabel!
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        let parentView = UIView(frame: CGRectMake(0, padding*2, frame.width, 40))
        parentView.backgroundColor = Color.common_text_bg_color
        parentView.layer.masksToBounds = true
        
        self.titleView = UiUtils.createCommonLabelWithAlign(0, y: padding, width: frame.width, fontSize: 14,
            align: NSTextAlignment.Center, title: "正在加载更多内容")
        self.titleView.center.y = 20
        self.titleView.center.x = frame.width/2
        
        indicator = UIActivityIndicatorView(frame: CGRectMake(padding, 0, 40-padding*2, 40-padding*2))
        indicator.center.y = 20
        
        indicator.startAnimating()
        
        parentView.addSubview(titleView)
        parentView.addSubview(indicator)
        self.addSubview(parentView)
    }
    
    func setStatus(status:Status) {
        
        if(status == Status.LoadingMore) {
            self.titleView.text = "正在加载更多内容"
            indicator.hidden = false
        }
        else if(status == Status.NoMoreData) {
            self.titleView.text = "没有更多数据"
            indicator.hidden = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}