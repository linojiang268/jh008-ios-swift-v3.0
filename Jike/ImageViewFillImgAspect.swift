//
//  ImageViewFillImgAspect.swift
//  Jike
//
//  Created by Iosmac on 15/6/27.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class ImageViewFillImgAspect: UIView {


    var imgView:UIImageView!


    override init(frame: CGRect) {
        super.init(frame: frame)

        imgView = UIImageView(frame: CGRectMake(0, 0, frame.width, frame.height))
        imgView.contentMode = UIViewContentMode.ScaleAspectFill

        self.addSubview(imgView)
    }

    func setImg(img:UIImage?) {
        if(img != nil) {
            let selfWH = self.frame.width/self.frame.height

            let imgWidth = img!.size.width
            let imgHeight = img!.size.height

            let imgWH = imgWidth/imgHeight

            if(selfWH > imgWH) {
                imgView.image = imageResize(img!, sizeChange: CGSize(width: self.frame.width,
                                            height: self.frame.width/imgWidth*imgHeight))
            }
            else {
                imgView.image = imageResize(img!, sizeChange: CGSize(width: self.frame.height/imgHeight*imgWidth,
                                            height: self.frame.height))
            }
        }
    }

    func imageResize(imageObj:UIImage, sizeChange:CGSize) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(sizeChange, false, 0)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}