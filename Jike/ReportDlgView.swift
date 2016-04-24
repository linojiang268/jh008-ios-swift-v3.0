//
//  ReportDlgView.swift
//  Jike
//
//  Created by Iosmac on 15/6/30.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

protocol ReportDlgViewDelegate {
    func reasonSelected(reason:String)
}

//举报对话框
class ReportDlgView: NSObject, UIActionSheetDelegate, UINavigationControllerDelegate {


    var parentVC:UIViewController!
    var isReasonDlg:Bool = false
    var actionReasonSheetView:UIActionSheet!
    var delegate:ReportDlgViewDelegate!
    var reasonArr = ["人身攻击", "暴力色情", "谣言及虚假信息", "广告", "违反法律法规", "其它"]

    init(vc:UIViewController, del:ReportDlgViewDelegate) {
        super.init()
        self.parentVC = vc
        self.delegate = del
        self.actionReasonSheetView = UIActionSheet(title: "选择举报原因", delegate: self,cancelButtonTitle: nil,
                                     destructiveButtonTitle: "取消",
                                     otherButtonTitles: "人身攻击", "暴力色情", "谣言及虚假信息", "广告", "违反法律法规", "其它")
    }

    func showDlg() {
        let actionSheetView = UIActionSheet(title: "举报不良内容", delegate: self, cancelButtonTitle: "取消",
                                            destructiveButtonTitle: "举报")
        actionSheetView.showInView(self.parentVC.view)
    }

    private func showReportReasonDlg() {
        actionReasonSheetView.showInView(self.parentVC.view)
    }

    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {

        if (buttonIndex == 0 && !isReasonDlg) {
            isReasonDlg = true
            showReportReasonDlg()
            return
        }

        if(isReasonDlg) {
            isReasonDlg = false
            if(buttonIndex>=1 && buttonIndex<reasonArr.count) {
                self.delegate.reasonSelected(reasonArr[buttonIndex-1])
            }
        }

        LogUtils.log("actionSheet():buttonIndex=\(buttonIndex)")
    }


}