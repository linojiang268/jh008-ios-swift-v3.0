//
//  PickOneStringVC.swift
//  Jike
//
//  Created by Iosmac on 15/9/10.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

protocol PickOneStringDelegate {

    func pickOneStringBack(string:String?)
}

//获取一个字符串的封装ViewController,这里用在添加自定义的兴趣爱好交友要求等处
class PickOneStringVC: JiBaseVC, BaseTitleViewDelegate {


    let padding = UISettings.common_table_padding

    private var titleString:String?
    private var limitChar:Int?
    private var myDelegate:PickOneStringDelegate?

    func setPageData(title:String?, delegate:PickOneStringDelegate, limitChar:Int?) {
        self.titleString = title
        self.myDelegate = delegate
        self.limitChar = limitChar
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleView = CommonTitleView(vc:self)
        titleView.setTitle(titleString != nil ? titleString! : "添加")
        titleView.myDelegate = self

        setBgImg()


        self.view.addSubview(titleView)
    }

    func rightOkBtnClick() {

    }

}