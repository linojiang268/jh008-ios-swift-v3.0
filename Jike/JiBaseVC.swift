//
//  JiBaseVC.swift
//  Jike
//
//  Created by ios on 15-4-21.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

//所有viewController的基类，封装了加载框，错误提示弹出框，收起键盘等功能
class JiBaseVC: UIViewController, UIAlertViewDelegate {


    var baseWidth:CGFloat!
    var baseHeight:CGFloat!

    var loadingView: LoadingView!
    var toastV:ToastView!
    var noContentView:NoContentView!

    var viewsNeedMoveWithKeyBoardInScroll = NSMutableArray()

    var viewsNeedMoveWithKeyBoardAbsolutely = NSMutableArray()

    var keyMoveView = "keyMoveView"
    var keyMoveHasMoved = "keyMoveHasMoved"
    var keyMoveOldY = "keyMoveOldY"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseWidth = self.view.frame.width
        baseHeight = self.view.frame.height

        self.automaticallyAdjustsScrollViewInsets = false
        
    }

    func setBgImg() {
        self.view.backgroundColor = Color.common_yellow_color //UIColor(patternImage: UIImage(named: "app_bg_img")!)
    }

    func showLoading() {
        closeKeyBoard()
        if(loadingView == nil) {
            loadingView = LoadingView(parent: self)
        }
        loadingView.setStatusLoading()
        self.view.addSubview(loadingView)
    }

    func dismissLoading() {
        
        if(loadingView != nil) {
            loadingView.removeFromSuperview()
        }
    }

    func showMsgBeforeDismiss(msg:String?) {
        closeKeyBoard()
        if(loadingView != nil) {
            loadingView.showMsgBeforeDismiss(msg)
        }
    }

    func showMsgToast(msg:String?) {
        closeKeyBoard()
        if(toastV == nil) {
            toastV = ToastView(parent: self)
        }

        self.view.addSubview(toastV)
        toastV.showMsg(msg, back: { () -> Void in
        })
    }

    func showMsgToast(msg:String?,back:()->Void) {
        closeKeyBoard()
        if(toastV == nil) {
            toastV = ToastView(parent: self)
        }
        self.view.addSubview(toastV)
        toastV.showMsg(msg, back: { () -> Void in
            back()
        })
    }
    
    func showErrorDlg(msg:String?, action:ActionTypeAfterDlgOkClicked) {
        dismissLoading()
        let dlg = UIAlertView(title: "提示", message: msg, delegate: self, cancelButtonTitle: "确定")
        dlg.tag = action.hashValue
        dlg.show()
    }

    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if(alertView.tag == ActionTypeAfterDlgOkClicked.CloseCurrent.hashValue) {
            UiUtils.closeCurrentVC()
        }
        else if(alertView.tag == ActionTypeAfterDlgOkClicked.GotoRoot.hashValue) {
            UiUtils.gotoRootVC()
        }
        else {

        }
    }

    func showNoContentView(tips:String?, paddingTop:CGFloat?) {
        if(tips != nil) {
            if(noContentView == nil) {
                noContentView = NoContentView(top:paddingTop)
            }
            noContentView.show(tips!, vc:self.view)
        }
    }

    func dismissNoContentView() {
        LogUtils.log("dismissNoContentView():noContentView=\(noContentView)")

        if(noContentView != nil) {
            noContentView.removeFromSuperview()
        }
    }

    func setClickOutsideCloseKeyBoardEnabled() {
        self.view.userInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "ousideViewClicked"))
    }

    func ousideViewClicked() {
        closeKeyBoard()
    }

    func closeKeyBoard() {
        let inputV = getInputFirstResp(self.view)
        if(inputV != nil) {
            if(inputV is UITextField) {
                let childInputF = inputV as! UITextField
                childInputF.resignFirstResponder()
            }
            else if(inputV is UITextView) {
                let childInputV = inputV as! UITextView
                childInputV.resignFirstResponder()
            }
        }
    }

    private func getInputFirstResp(view:UIView?) -> UIView? {
        if(view != nil && view!.subviews.count>0) {
            for child in view!.subviews {
                if(child is UITextField) {
                    let childInputF = child as! UITextField
                    if(childInputF.isFirstResponder()) {
                        return childInputF
                    }
                }
                else if(child is UITextView) {
                    let childInputV = child as! UITextView
                    if(childInputV.isFirstResponder()) {
                        return childInputV
                    }
                }
                else {
                    let v = getInputFirstResp(child)
                    if(v is UITextField || v is UITextView) {
                        return v
                    }
                }
            }
        }

        return nil
    }

    private func setMoveViewsWithKeyBoardEnabled() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardOpend:",
                                                         name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardClosed:",
                                                         name: UIKeyboardWillHideNotification, object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:",
                                                         name: UIKeyboardWillChangeFrameNotification, object: nil)
    }

    func keyboardWillChangeFrame(notifiycation:NSNotification) {
        let info = notifiycation.userInfo!
        let boradHeight = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height

        LogUtils.log("keyboardWillChangeFrame():boradHeight=\(boradHeight)")

        if(viewsNeedMoveWithKeyBoardAbsolutely.count>0) {

            for dic in viewsNeedMoveWithKeyBoardAbsolutely {

                let v = (dic.valueForKey(keyMoveView) as! UIView)
                v.frame.origin.y = (dic.valueForKey(keyMoveOldY) as! CGFloat) - boradHeight

                dic.setValue(true, forKey: keyMoveHasMoved)
            }
        }
    }

    func keyboardOpend(notifiycation:NSNotification) {
        let info = notifiycation.userInfo!
        let boradHeight = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height

        LogUtils.log("keyboardOpend():boradHeight=\(boradHeight)")

        if(viewsNeedMoveWithKeyBoardInScroll.count>0) {

            let firstInput = getInputFirstResp(self.view)
            LogUtils.log("keyboardOpend():firstInput?.frame.maxY=\(firstInput?.frame.maxY)")
            if(firstInput != nil) {
                let windowRect = firstInput!.convertRect(firstInput!.frame, toView: UiUtils.getWindow())
                let viewToBottomDistance = baseHeight - windowRect.maxY

                if(viewToBottomDistance < boradHeight) {

                    let movedDistance = boradHeight-viewToBottomDistance

                    LogUtils.log("keyboardOpend():movedDistance=\(firstInput?.frame.maxY)")

                    for dic in viewsNeedMoveWithKeyBoardInScroll {

                        if(!(dic.valueForKey(keyMoveHasMoved) as! Bool)) {

                            if(dic.valueForKey(keyMoveView) is UIScrollView) {
                                let scr = dic.valueForKey(keyMoveView) as! UIScrollView
                                scr.contentOffset = CGPoint(x: scr.contentOffset.x, y: scr.contentOffset.y+movedDistance)
                            }
                            else {
                                let v = (dic.valueForKey(keyMoveView) as! UIView)
                                v.frame.origin.y = (dic.valueForKey(keyMoveOldY) as! CGFloat) - movedDistance

                                dic.setValue(true, forKey: keyMoveHasMoved)
                            }
                        }
                    }
                }
            }
        }
    }

    func keyboardClosed(notifiycation:NSNotification) {
        let info = notifiycation.userInfo!
        let boradHeight = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().height

        LogUtils.log("keyboardClosed():boradHeight=\(boradHeight)")

        if(viewsNeedMoveWithKeyBoardInScroll.count>0 || viewsNeedMoveWithKeyBoardAbsolutely.count>0) {
            for dic in viewsNeedMoveWithKeyBoardInScroll {

                if(dic.valueForKey(keyMoveHasMoved) as! Bool) {

                    let v = (dic.valueForKey(keyMoveView) as! UIView)
                    v.frame.origin.y = (dic.valueForKey(keyMoveOldY) as! CGFloat)

                    dic.setValue(false, forKey: keyMoveHasMoved)
                }
            }
            for dicA in viewsNeedMoveWithKeyBoardAbsolutely {

                if(dicA.valueForKey(keyMoveHasMoved) as! Bool) {

                    let vA = (dicA.valueForKey(keyMoveView) as! UIView)
                    vA.frame.origin.y = (dicA.valueForKey(keyMoveOldY) as! CGFloat)

                    dicA.setValue(false, forKey: keyMoveHasMoved)
                }
            }
        }
    }

    func addViewsNeedMoveInScrollWhenKeyBoardChange(views:[UIView]) {
        setMoveViewsWithKeyBoardEnabled()
        self.viewsNeedMoveWithKeyBoardInScroll.removeAllObjects()
        for v in views {
            let dic = NSMutableDictionary()
            dic.setValue(v, forKey: keyMoveView)
            dic.setValue(false, forKey: keyMoveHasMoved)
            dic.setValue(v.frame.origin.y, forKey: keyMoveOldY)
            if(v is UIScrollView) {
                let scr = v as! UIScrollView
                scr.contentSize = CGSize(width: scr.contentSize.width,
                    height: scr.contentSize.height + UISettings.common_key_board_height)
            }
            self.viewsNeedMoveWithKeyBoardInScroll.addObject(dic)
        }
    }

    func addViewsNeedMoveAbsolutelyWhenKeyBoardChange(views:[UIView]) {
        setMoveViewsWithKeyBoardEnabled()
        self.viewsNeedMoveWithKeyBoardAbsolutely.removeAllObjects()
        for v in views {
            let dic = NSMutableDictionary()
            dic.setValue(v, forKey: keyMoveView)
            dic.setValue(false, forKey: keyMoveHasMoved)
            dic.setValue(v.frame.origin.y, forKey: keyMoveOldY)
            self.viewsNeedMoveWithKeyBoardAbsolutely.addObject(dic)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}