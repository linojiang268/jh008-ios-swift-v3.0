//
//  UiUtils.swift
//  Jike
//
//  Created by ios on 15-4-21.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

struct UiUtils {
    
    static var baseWidth:CGFloat!
    static var baseHeight:CGFloat!
    

    //延时进入tab界面
    static func gotoRootVCDelay() {
        let delay = DataSettings.show_msg_delay_time * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.gotoRootVC()
        }
    }

    //延时关闭当前界面
    static func closeCurrentVCDelay() {
        let delay = DataSettings.show_msg_delay_time * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.closeCurrentVC()
        }
    }

    //进入tab界面
    static func gotoRootVC() {
        DataUtils.getAppDelegate().getRootNavVC().popToRootViewControllerAnimated(true)
    }

    //关闭当前界面
    static func closeCurrentVC() {
        DataUtils.getAppDelegate().getRootNavVC().popViewControllerAnimated(true)
    }

    //打开一个界面
    static func openOneNewVC(vc:UIViewController) {
        DataUtils.getAppDelegate().getRootNavVC().pushViewController(vc, animated: true)
    }

    //通过自定义动画打开一个新界面
    static func openOneNewVCWithPresentAnimation(vc:UIViewController)
    {
        let transition:CATransition = CATransition()
        transition.type = kCATransitionMoveIn;
        transition.duration = 0.2
        transition.subtype = kCATransitionFromTop;
        DataUtils.getAppDelegate().getRootNavVC().view.layer.addAnimation(transition, forKey: kCATransition)
        DataUtils.getAppDelegate().getRootNavVC().pushViewController(vc, animated: false)
    
    }

    //通过自定义动画关闭一个界面
    static func closeCurrentVCWithDismissAnimation()
    {
        let transition:CATransition = CATransition()
        transition.type = kCATransitionReveal;
        transition.duration = 0.3
        transition.subtype = kCATransitionFromBottom;
        DataUtils.getAppDelegate().getRootNavVC().view.layer.addAnimation(transition, forKey: kCATransition)
        DataUtils.getAppDelegate().getRootNavVC().popViewControllerAnimated(false)
        
    }

    //不带动画打开一个新界面
    static func openOneNewVcNoAnim(vc:UIViewController) {
        DataUtils.getAppDelegate().getRootNavVC().pushViewController(vc, animated: false)
    }

    //获取当前正在显示的vc
    static func getCurrentVC() -> UIViewController {
        return DataUtils.getAppDelegate().getRootNavVC().visibleViewController!
    }
    
    static func getBaseWidth() -> CGFloat {
        return baseWidth
    }
    
    static func setBaseWidth(width:CGFloat) {
        LogUtils.log("setBaseWidth():width=\(width)")
        baseWidth = width
    }
    
    static func getBaseHeight() -> CGFloat {
        LogUtils.log("getBaseHeight():baseHeight=\(baseHeight)")
        return baseHeight
    }
    
    static func setBaseHeight(height:CGFloat) {
        baseHeight = height
    }

    //将颜色值转换为img
    static func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    //在app图标上显示未读消息数
    static func showAppIconBadge(num:Int) {
        UIApplication.sharedApplication().applicationIconBadgeNumber = num
        LogUtils.log("showAppIconBadge():num=\(num)")
    }

    //创建分割线
    static func createDividerLine(x:CGFloat, y:CGFloat, width:CGFloat) -> CALayer {
        let line = CALayer()
        line.frame = CGRectMake(x, y, width, UISettings.common_line_height)
        line.backgroundColor = Color.common_line_color.CGColor
        return line
    }

    //创建竖直的分割线
    static func createDividerLineVertical(x:CGFloat, y:CGFloat, height:CGFloat) -> CALayer {
        let line = CALayer()
        line.frame = CGRectMake(x, y, UISettings.common_line_height, height)
        line.backgroundColor = Color.common_line_color.CGColor
        return line
    }

    //创建一个带左标志的输入框，注册、找回密码界面有用到
    static func createUserTextField(frame: CGRect, leftImg:UIImage, holder:String,
                                    keyBoardType:UIKeyboardType) -> UITextField {

        let textField = UITextField(frame: frame)
        textField.backgroundColor = Color.white
        textField.leftViewMode = UITextFieldViewMode.Always
        textField.layer.cornerRadius = UISettings.common_corner_size
        textField.layer.masksToBounds = true
        textField.keyboardType = keyBoardType
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center

        textField.placeholder = holder
        textField.textColor = UIColor.darkGrayColor()

        let leftView = UIImageView(frame: CGRectMake(0, 0, frame.height, frame.height))
        leftView.contentMode = UIViewContentMode.Center
        leftView.image = leftImg
        textField.leftView = leftView

        return textField
    }

    //创建圆形图标，一般是头像
    static func createRoundHeadIcon(frame:CGRect) -> UIImageView {
        let imgV = UIImageView(frame: frame)
        imgV.layer.cornerRadius = frame.width/2
        imgV.layer.masksToBounds = true
        imgV.contentMode = UIViewContentMode.ScaleAspectFill
        return imgV
    }

    //创建一个通用设置的UIScrollView
    static func createCommonScrollView(frame:CGRect) -> UIScrollView {
        let scrollView = UIScrollView(frame: frame)
        scrollView.pagingEnabled = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        //scrollView.bounces = false
        scrollView.contentSize = CGSize(width: frame.width, height: frame.height)
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        return scrollView
    }

    //获取系统顶部状态栏的高度
    static func getStatusBarHeight() -> CGFloat {
        return UIApplication.sharedApplication().statusBarFrame.height
    }

    //从RGB值中获取UIColor
    static func getColorFromRGB(r:CGFloat, g:CGFloat, b:CGFloat, alpha:CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }

    static func setCenterXY(view:UIView, x:CGFloat, y:CGFloat) {
        view.center.x = x
        view.center.y = y
    }

    //获取带属性的字符串
    static func getParagraphAttributeString(s:String) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4

        let attrString = NSMutableAttributedString(string: s)
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle,
                                range:NSMakeRange(0, attrString.length))
        return attrString
    }

    //在固定宽度情况下，根据字号和文字内容重设view的高，此函数不限制行数
    static func resetViewHeightByChar(view:UIView, text:String?, viewWidth:CGFloat, fontSize:CGFloat) {
        resetViewHeightByChar(view, text:text, viewWidth:viewWidth, fontSize:fontSize, maxLine:0)
    }

    //在固定宽度情况下，根据字号和文字内容重设view的高，此函数可以限制行数
    static func resetViewHeightByChar(view:UIView, text:String?, viewWidth:CGFloat, fontSize:CGFloat, maxLine:Int) {
        if(DataUtils.isStringNotEmpty(text)) {
            let newHeight = heightForView(text!, font: fontSize, width: viewWidth, maxLine:maxLine)
            //getDynamicTexHeightByChar(text, viewWidth: viewWidth, fontSize: fontSize)
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, viewWidth, newHeight)
        }
        else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, viewWidth, 0)
        }
    }

    //在固定高度情况下，根据文字内容和字号重设控件宽度
    static func resetViewWidthByChar(view:UIView, text:String, viewHeight:CGFloat, font:UIFont) {

        let newWidth = getDynamicTextWidthByChar(text, viewHeight: viewHeight, font: font)
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, newWidth+1, viewHeight)
    }

    //在固定高度情况下，根据文字内容和字号重设控件宽度
    static func resetViewWidthByChar(view:UIView, text:String?, viewHeight:CGFloat, fontSize:CGFloat) {
        if(DataUtils.isStringNotEmpty(text)) {
            let newWidth = getDynamicTextWidthByChar(text!, viewHeight: viewHeight, fontSize: fontSize)
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, newWidth+1, viewHeight)
        }
        else {
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, 0, viewHeight)
        }
    }

    //通过label实际填充值的方式获取实际应该有的宽度
    static func widthForView(text:String, viewHeight:CGFloat, fontSize:CGFloat) -> CGFloat {

        let label:UILabel = UILabel(frame: CGRectMake(0, 0, CGFloat.max, viewHeight))
        label.numberOfLines = 1
        label.font = UISettings.getFont(fontSize)
        label.attributedText = getParagraphAttributeString(text)

        label.sizeToFit()
        return label.frame.width
    }

    //通过label实际填充值的方式获取实际应该有的高度，无函数限制
    static func heightForView(text:String, font:CGFloat, width:CGFloat) -> CGFloat{
        return heightForView(text, font:font, width:width, maxLine:0)
    }

    //通过label实际填充值的方式获取实际应该有的高度，有行数限制
    static func heightForView(text:String, font:CGFloat, width:CGFloat, maxLine:Int) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = maxLine
        label.lineBreakMode = NSLineBreakMode.ByCharWrapping
        label.font = UISettings.getFont(font)
        label.attributedText = getParagraphAttributeString(text)
        label.sizeToFit()
        return label.frame.height
    }

    //根据文字内容、字号、控件高度，动态计算控件的宽度
    static func getDynamicTextWidthByChar(text:String, viewHeight:CGFloat, font:UIFont) -> CGFloat {
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle();
        paragraphStyle.lineSpacing = CGFloat(4);//调整行间距

        let ns:NSString = NSString(string: text)

        let size0 = ns.boundingRectWithSize(CGSize(width: CGFloat.max, height:viewHeight),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: font, NSParagraphStyleAttributeName:paragraphStyle],
            context: nil).size

        return size0.width
    }

    //根据文字内容、字号、控件高度，动态计算控件的宽度
    static func getDynamicTextWidthByChar(text:String, viewHeight:CGFloat, fontSize:CGFloat) -> CGFloat {
    
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle();
        paragraphStyle.lineSpacing = CGFloat(4);//调整行间距
        
        let ns:NSString = NSString(string: text)
        
        let size0 = ns.boundingRectWithSize(CGSize(width: CGFloat.max, height:viewHeight),
        options: NSStringDrawingOptions.UsesLineFragmentOrigin,
        attributes: [NSFontAttributeName: UISettings.getFont(fontSize), NSParagraphStyleAttributeName:paragraphStyle],
        context: nil).size
    
        return size0.width
    }

    //根据文字内容、字号、控件宽度，动态计算控件的高度
    static func getDynamicTexHeightByChar(text:String, viewWidth:CGFloat, fontSize:CGFloat) -> CGFloat {
        
        let paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle();
        paragraphStyle.lineSpacing = CGFloat(4);//调整行间距
        
        let ns:NSString = NSString(string: text)
        
        let size0 = ns.boundingRectWithSize(CGSize(width: viewWidth, height:CGFloat.max),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: UISettings.getFont(fontSize), NSParagraphStyleAttributeName:paragraphStyle],
            context: nil).size
        
        return size0.height
    }

    //创建通用的UILabel
    static func createCommonLabelWithAlign(x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat, fontSize:CGFloat,
                                           align:NSTextAlignment, title:NSString?) -> UILabel {

        let laTitleV = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))

        laTitleV.textColor = Color.common_text_color_black
        laTitleV.font = UISettings.getFont(fontSize)
        laTitleV.numberOfLines = 0
        laTitleV.textAlignment = align
        laTitleV.lineBreakMode = NSLineBreakMode.ByCharWrapping
        laTitleV.text = title as? String

        return laTitleV
    }

    //创建通用的UILabel
    static func createCommonLabel(x:CGFloat, y:CGFloat, width:CGFloat, fontSize:CGFloat, title:NSString?) -> UILabel {
        
        let laTitleV = UILabel(frame: CGRect(x: x, y: y, width: width, height: fontSize))
        
        laTitleV.textColor = Color.common_text_color_gray
        laTitleV.font = UISettings.getFont(fontSize)
        laTitleV.text = title as? String
        
        return laTitleV
    }

    //创建通用的UILabel
    static func createCommonLabelWithAlign(x:CGFloat, y:CGFloat, width:CGFloat, fontSize:CGFloat, align:NSTextAlignment,title:NSString?) -> UILabel {
        
        let laTitleV = UILabel(frame: CGRect(x: x, y: y, width: width, height: fontSize))
        
        laTitleV.textColor = Color.common_text_color_gray
        laTitleV.font = UISettings.getFont(fontSize)
        laTitleV.numberOfLines = 0
        laTitleV.textAlignment = align
        laTitleV.lineBreakMode = NSLineBreakMode.ByCharWrapping
        laTitleV.text = title as? String
        
        return laTitleV
    }

    static func createCommonFieldWithAlign(x:CGFloat,y:CGFloat,width:CGFloat,fontSize:CGFloat,
                                           align:NSTextAlignment,title:String?) -> UITextField {

        let laTitleV = UITextField(frame: CGRect(x: x, y: y, width: width,
                                                 height: fontSize))
        laTitleV.leftViewMode = UITextFieldViewMode.Always
        laTitleV.layer.cornerRadius = UISettings.common_corner_size
        laTitleV.layer.masksToBounds = true
        laTitleV.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        laTitleV.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        laTitleV.textColor = Color.white
        laTitleV.font = UISettings.getFont(fontSize)
        laTitleV.text = title
        laTitleV.borderStyle = UITextBorderStyle.None

        return laTitleV
    }

    //去掉某父控件中得所有子控件
    static func removeAllChildViews(parentView:UIView) {
        for v in parentView.subviews {
            v.removeFromSuperview()
        }
    }
    
    static func getWindow() -> UIWindow? {
        return UIApplication.sharedApplication().delegate?.window!
    }
    
    static func removeLastViewControllerInNavigationVc(navi:UINavigationController?)
    {
        if (navi==nil)
        {
            return
        }
        let controllers = NSMutableArray(array:navi!.viewControllers)
        controllers.removeLastObject()
        navi!.setViewControllers(controllers as [AnyObject] as! [UIViewController], animated: true)
    }
}