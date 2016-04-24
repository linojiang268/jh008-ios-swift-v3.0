//
//  LoadingView.swift
//  Jike
//
//  Created by Iosmac on 15/6/16.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {

    var parentVC: UIViewController!

    let baseWidth = UiUtils.getBaseWidth()
    let baseHeight = UiUtils.getBaseHeight()

    var parentView:UIView!
    var indicator:UIActivityIndicatorView!
    var msgView:UILabel!

    init(parent:UIViewController) {
        super.init(frame:CGRectMake(0, 0, baseWidth, baseHeight))

        self.parentVC = parent

        initView()

        self.userInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "outsideClicked"))
    }

    private func initView() {

        parentView = UIView(frame: CGRectMake(0, 0, baseWidth/2.2, baseWidth/4))
        parentView.center.x = baseWidth/2
        parentView.center.y = baseHeight/2
        parentView.backgroundColor = Color.common_black_bg
        parentView.layer.cornerRadius = UISettings.common_corner_size
        parentView.layer.masksToBounds = true

        indicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, parentView.frame.width, parentView.frame.height))
        indicator.startAnimating()

        msgView = UiUtils.createCommonLabelWithAlign(UISettings.common_table_padding, y: 0,
                                                     width: parentView.frame.width-UISettings.common_table_padding*2,
                                                     fontSize: 14, align: NSTextAlignment.Center, title: "")
        msgView.hidden = true
        msgView.textColor = Color.white

        parentView.addSubview(indicator)
        parentView.addSubview(msgView)
        self.addSubview(parentView)
    }

    func setStatusLoading() {
        msgView.hidden = true
        msgView.text = ""
        indicator.startAnimating()
        indicator.hidden = false
    }

    func showMsgBeforeDismiss(msg:String?) {

//        let myTimer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self,
//                                                                    selector:Selector("myPerformeCode:"),
//                                                                    userInfo: nil, repeats: false)
        msgView.text = msg
        UiUtils.resetViewHeightByChar(msgView, text: msgView.text!, viewWidth: msgView.frame.width, fontSize: 14)
        msgView.hidden = false
        msgView.center.y = parentView.frame.height/2

        self.indicator.stopAnimating()
        self.indicator.hidden = true

        let delay = DataSettings.show_msg_delay_time * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.removeFromSuperview()
        }
    }

    func myPerformeCode(timer : NSTimer) {


    }

    func outsideClicked() {
        self.removeFromSuperview()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}