//
//  MyTabGestureRecognize.swift
//  Jike
//
//  Created by Iosmac on 15/5/16.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

//封装了一个UITapGestureRecognizer，方便向其中的data传按钮对应的数据值
class MyTapGestureRecognizer: UITapGestureRecognizer {
    
    var data:AnyObject?
    
}