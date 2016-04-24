//
//  ToastView.swift
//  Jike
//
//  Created by Iosmac on 15/6/16.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class ToastView: UIView {

    var parentVC: UIViewController!

    let baseWidth = UiUtils.getBaseWidth()
    let baseHeight = UiUtils.getBaseHeight()

    var parentView:UIView!
    var msgView:UILabel!


    init(parent:UIViewController) {
        super.init(frame:CGRectMake(0, baseHeight-120, baseWidth/2.2, baseWidth/4))

        self.parentVC = parent

        initView()

        self.userInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "outsideClicked"))
    }

    private func initView() {

        parentView = UIView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height))
        parentView.layer.cornerRadius = UISettings.common_corner_size
        parentView.layer.masksToBounds = true
        parentView.backgroundColor = Color.common_black_bg

        msgView = UiUtils.createCommonLabelWithAlign(UISettings.common_table_padding, y: 0,
                                                    width: parentView.frame.width-UISettings.common_table_padding*2,
                                                    fontSize: 14, align: NSTextAlignment.Center, title: "")
        msgView.textColor = Color.white

        parentView.addSubview(msgView)
        self.addSubview(parentView)

        self.center.x = baseWidth/2
        self.center.y = baseHeight/2
    }

    func showMsg(msg:String?,back:()->Void) {
        if(msg != nil) {
            msgView.attributedText = getParagraphAttributeString(msg!)
            UiUtils.resetViewHeightByChar(msgView, text: msgView.text!, viewWidth: msgView.frame.width, fontSize: 14)

            msgView.center.y = parentView.frame.height/2

            let delay = 2 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.removeFromSuperview()
                back()
            }
        }
    }

    func getParagraphAttributeString(s:String) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = NSTextAlignment.Center

        let attrString = NSMutableAttributedString(string: s)
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle,
        range:NSMakeRange(0, attrString.length))
        return attrString
    }

    func outsideClicked() {
        self.removeFromSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}