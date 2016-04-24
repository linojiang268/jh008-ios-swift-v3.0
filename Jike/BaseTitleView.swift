//
//  BaseTitleView.swift
//  Gather4
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

@objc protocol BaseTitleViewDelegate {
    
    optional func leftBackClicked()
    optional func rightOkBtnClick()
    optional func rightMoreBtnClicked()
    
    optional func titleSelfClicked()
}

class BaseTitleView:UINavigationBar {
    
    var baseWidth:CGFloat!
    var statusBarHeight:CGFloat!
    
    var titleView:UILabel!
    
    var leftBtn:UIButton!
    var rightBtn:UIButton!

    var leftRightPadding:CGFloat = 10
    var fontSize:CGFloat = 15
    
    var parentVC:UIViewController!
    var myDelegate: BaseTitleViewDelegate!
    
    
    init(vc:UIViewController) {
        super.init(frame:CGRectMake(0, 0, UiUtils.getBaseWidth(), UISettings.common_title_height))
        
        self.layer.masksToBounds = true
        self.layer.addSublayer(UiUtils.createDividerLine(0,
                               y: UISettings.common_title_height - UISettings.common_line_height,
                               width: UiUtils.getBaseWidth()))
        
        parentVC = vc
        
        self.baseWidth = UiUtils.getBaseWidth()
        self.statusBarHeight = UiUtils.getStatusBarHeight()
        
        self.titleView = UILabel(frame: CGRectMake(0, 0, self.baseWidth/1.5, UISettings.title_view_title_text_size))
        self.titleView.textColor = Color.titleTextColor
        self.titleView.font = UISettings.getFontBold(UISettings.title_view_title_text_size)
        self.titleView.textAlignment = NSTextAlignment.Center
        self.titleView.center.x = self.center.x
        self.titleView.center.y = getCenterY()
        self.titleView.hidden = false
        
        let btnLength = UISettings.common_title_height-self.statusBarHeight
        
        self.leftBtn = UIButton(frame: CGRectMake(0, self.statusBarHeight, btnLength, btnLength))
        self.rightBtn = UIButton(frame: CGRectMake(self.baseWidth-leftRightPadding-btnLength*1.7,
                                                   self.statusBarHeight, btnLength*1.7, btnLength))
        
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        
        leftBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: leftRightPadding, bottom: 0, right: 0)
        
        self.leftBtn.titleLabel?.font = UISettings.getFont(fontSize)
        self.rightBtn.titleLabel?.font = UISettings.getFont(fontSize)
        
        self.leftBtn.setTitleColor(Color.styleColor, forState: UIControlState.Normal)
        self.rightBtn.setTitleColor(Color.styleColor, forState: UIControlState.Normal)
        
        self.leftBtn.addTarget(self, action: "leftBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.rightBtn.addTarget(self, action: "rightBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(self.titleView)
        self.addSubview(self.leftBtn)
        self.addSubview(self.rightBtn)
        
        self.userInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target:self, action:"titleViewClicked"))
        
        hideLeftAndRightButton()
    }
    
    private func getCenterY() -> CGFloat {
        return (UISettings.common_title_height-self.statusBarHeight)/2+self.statusBarHeight
    }
    
    func setTitle(title:String) {
        self.titleView.text = title
    }
    
    func getTitle() -> String {
        return self.titleView.text != nil ? self.titleView.text! : ""
    }
    
    func hideLeftAndRightButton() {
        self.leftBtn.hidden = true
        self.rightBtn.hidden = true
    }
    
    func hideAllSubViews() {
        self.leftBtn.hidden = true
        self.titleView.hidden = true
        self.rightBtn.hidden = true
    }
    
    func getTitleContentHeight() -> CGFloat {
        return UISettings.common_title_height-self.statusBarHeight
    }
    
    func setNoAlpha() {
        self.backgroundColor = Color.common_text_bg_color
    }
    
    func leftBtnClick() {
        if(myDelegate != nil && myDelegate.leftBackClicked != nil) {
            myDelegate.leftBackClicked?()
        }
        else {
            UiUtils.closeCurrentVC()
        }
    }
    
    func rightBtnClick() {
        if(myDelegate != nil) {
            myDelegate.rightOkBtnClick?()
        }
        self.titleView.becomeFirstResponder()
    }
    
    func titleViewClicked() {
        if(myDelegate != nil) {
            myDelegate.titleSelfClicked?()
        }
        self.titleView.becomeFirstResponder()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}