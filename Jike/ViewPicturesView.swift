//
//  ViewPicturesView.swift
//  Jike
//
//  Created by Iosmac on 15/6/24.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class ViewPicturesView: UIView {

    var parentVC: UIViewController!

    let baseWidth = UiUtils.getBaseWidth()
    let baseHeight = UiUtils.getBaseHeight()

    var scrollView: UIScrollView!

    var deleteBtn: UIButton!

    var deleteBtnLength:CGFloat!


    init(parent:UIViewController) {
        super.init(frame:CGRectMake(0,0,self.baseWidth,self.baseHeight))

        self.parentVC = parent
        self.layer.backgroundColor = UIColor.blackColor().CGColor
        self.deleteBtnLength = UISettings.common_title_height - UiUtils.getStatusBarHeight()

        initView()
    }

    private func initView() {
        scrollView = UiUtils.createCommonScrollView(CGRectMake(0,0, self.baseWidth, self.baseHeight))
        scrollView.pagingEnabled = true

        deleteBtn = UIButton(frame: CGRectMake(self.baseWidth-self.deleteBtnLength, 0,
                                               self.deleteBtnLength, self.deleteBtnLength))

        deleteBtn.addTarget(self, action: "deleteBtnClicked", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(scrollView)
        //self.addSubview(deleteBtn)
    }

    func deleteBtnClicked() {

    }

    func setImgUrls(urlArr:[String]) {
        UiUtils.removeAllChildViews(self.scrollView)
        if(urlArr.count > 0) {
            self.scrollView.contentSize = CGSize(width: baseWidth*CGFloat(urlArr.count), height: baseHeight)
            for index in 0...urlArr.count-1 {
                let url = urlArr[index]
                let imgV = UIImageView(frame: CGRectMake(baseWidth*CGFloat(index), 0, baseWidth, baseHeight))
                imgV.contentMode = UIViewContentMode.ScaleAspectFit
                imgV.userInteractionEnabled = true
                imgV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "outsideClicked"))
                imgV.sd_setImageWithURL(NSURL(string: url)!)
                scrollView.addSubview(imgV)
            }
        }
    }

    func setImgData(imgArr:[UIImage?]) {
        UiUtils.removeAllChildViews(scrollView)
        if(imgArr.count > 0) {
            scrollView.contentSize = CGSize(width: baseWidth*CGFloat(imgArr.count), height: baseHeight)
            for index in 0...imgArr.count-1 {
                let img = imgArr[index]
                let imgV = UIImageView(frame: CGRectMake(baseWidth*CGFloat(index), 0, baseWidth, baseHeight))
                imgV.contentMode = UIViewContentMode.ScaleAspectFit
                imgV.userInteractionEnabled = true
                imgV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "outsideClicked"))
                imgV.image = img
                scrollView.addSubview(imgV)
            }
        }
    }

    func setInitIndex(index:Int) {
        scrollView.contentOffset = CGPoint(x: baseWidth*CGFloat(index), y: 0)
    }

    func outsideClicked() {
        self.hideViewPictureWithAnimation()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /**
     * 动画显示当前视图
     */
    func showViewPictureWithAnimation()
    {
        let animation:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
        animation.duration = 0.3;

        let values:NSMutableArray = NSMutableArray()
        values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(0.6, 0.6, 1.0)))
        values.addObject(NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        animation.values = values as [AnyObject]!;
        let animation2:CABasicAnimation = CABasicAnimation()
        animation2.keyPath = "backgroundColor"
        animation2.duration = 0.4
        animation2.fromValue = UIColor(red: 200, green: 200, blue: 200, alpha: 0.0).CGColor
        animation2.toValue = UIColor.blackColor().CGColor
        self.scrollView.layer.addAnimation(animation, forKey: nil)

        self.layer.addAnimation(animation2, forKey: nil)

    }
    /**
    *  动画隐藏当前视图
    */
    func hideViewPictureWithAnimation()
    {
        UIView.animateWithDuration(0.3, animations: { [unowned self]() -> Void in
           self.alpha = 0
        }) { [unowned self](isComplete) -> Void in
            self.removeFromSuperview()
        }
    }
}