//
//  DataMyNTYPhoto.swift
//  Jike
//
//  Created by Iosmac on 15/7/28.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class DataMyNTYPhoto: NSObject, NYTPhoto {


    var image: UIImage?
    var placeholderImage: UIImage?
    var index:Int! //对象的索引
    let attributedCaptionTitle: NSAttributedString
    let attributedCaptionSummary = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
    let attributedCaptionCredit = NSAttributedString(string: "", attributes: [NSForegroundColorAttributeName: UIColor.darkGrayColor()])
    

    init(image: UIImage?, attributedCaptionTitle: NSAttributedString) {
        self.image = image
        self.attributedCaptionTitle = attributedCaptionTitle
        super.init()
    }

    convenience init(attributedCaptionTitle: NSAttributedString) {
        self.init(image: nil, attributedCaptionTitle: attributedCaptionTitle)
    }
}