//
//  ImgBgView.swift
//  Jike
//
//  Created by Iosmac on 15/5/11.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

//用于虚化模糊效果的控件，用在MineVC的头像背景上
class ImgBgView: UIView {
    

    var imgBgView:UIImageView!
    var blur:FXBlurView!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.imgBgView = UIImageView(frame:CGRectMake(0, 0, frame.width*1.1, frame.height*1.1))
        self.imgBgView.contentMode = UIViewContentMode.ScaleAspectFill
        self.imgBgView.center.x = frame.width/2
        self.imgBgView.center.y = frame.height/2
        self.imgBgView.alpha = 0.7
        self.backgroundColor = UIColor.blackColor()
        self.layer.masksToBounds = true
        //setImgView(UIImage(named: "common_picture_default_img")!)

        self.blur = FXBlurView(frame: CGRectMake(0, 0, frame.width, frame.height))
        self.blur.blurEnabled = true
        self.blur.blurRadius = 20
        self.blur.tintColor = UIColor.blackColor()

        self.addSubview(self.imgBgView)
        self.addSubview(self.blur)
    }

    func setImaURL(url:String?) {
        if(DataUtils.isStringNotEmpty(url)) {
            self.imgBgView.sd_setImageWithURL(NSURL(string: DataUtils.getUTF8String(url!)),
                                              placeholderImage: UIImage(named: "common_head_icon_default_img"),
                                                options:SDWebImageOptions.RetryFailed)
            { (img, error, type, url) -> Void in

            }
        }
    }
    
//    func setImgView(image:UIImage) {
//        
//        var inputImage:CIImage = CIImage(image: image)//UIImage(named: "every_recommend_test")
//
//        // create gaussian blur filter
//        var filter:CIFilter = CIFilter(name: "CIGaussianBlur")
//        filter.setValue(inputImage, forKey: kCIInputImageKey)
//        filter.setValue(NSNumber(float: 9), forKey: "inputRadius")
//        
//        // blur image
//        let result: CIImage = filter.valueForKey(kCIOutputImageKey) as! CIImage
//        let context:CIContext = CIContext(options: nil)
//
//        var cgImage: CGImageRef = context.createCGImage(result, fromRect: inputImage.extent())
//
//        var image:UIImage = UIImage(CGImage: cgImage)!
//
//
//        self.imgBgView.contentMode = UIViewContentMode.ScaleAspectFill
//        self.imgBgView.image = image;
//
//        
//    }

//    func imageWithImage(img:UIImage) -> UIImage {
//
//        UIGraphicsBeginImageContext(CGSize(width: img.size.width, height: img.size.height))
//
//        img.drawInRect(CGRectMake(-10, -10, width+20, height+20))
//
//        var newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
//
//        UIGraphicsEndImageContext()
//
//        return newImage
//    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}