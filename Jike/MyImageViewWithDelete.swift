//
//  MyImageViewWithDelete.swift
//  Jike
//
//  Created by Iosmac on 15/7/6.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class MyImageViewWithDelete: UIView {

    var imgV:UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        imgV = UIImageView(frame: CGRectMake(0, 0, frame.width, frame.height))

        var deleteBtn = UIButton(frame: CGRectMake(frame.width-42, 0, 42, 42))
        deleteBtn.setTitle("删除", forState: UIControlState.Normal)
        deleteBtn.addTarget(self, action: "deleteBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        deleteBtn.setTitleColor(Color.common_text_bg_color, forState: UIControlState.Normal)

        self.addSubview(imgV)
        self.addSubview(deleteBtn)
        self.bringSubviewToFront(deleteBtn)
    }

    func setImgData(img:UIImage) {
        imgV.image = img
    }

    func deleteBtnClicked() {

        self.removeFromSuperview()

        LogUtils.log("deleteBtnClicked()")
    }


    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}