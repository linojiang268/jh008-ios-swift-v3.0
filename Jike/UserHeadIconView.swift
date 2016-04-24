//
//  UserHeadIconView.swift
//  Gather4
//
//  Created by apple on 15/11/5.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class UserHeadIcon: UIImageView, DlgSelectImgSourceDelegate {
    
    private var imgSelector:DlgSelectImgSource!
    
    
    init(frame: CGRect, vc:UIViewController) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = frame.height/2
        self.layer.masksToBounds = true
        self.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.userInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "headIconClicked"))
        
        imgSelector = DlgSelectImgSource(vc: vc, dele: self, isSingleSelect: true, maxNumIfIsMutiSelect: nil)
    }
    
    func headIconClicked() {
        imgSelector.showDlg()
    }
    
    func imgPicked(img:[UIImage]) {
        self.image = img[0]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}