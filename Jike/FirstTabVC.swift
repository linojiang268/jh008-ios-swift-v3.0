//
//  FirstTabVC.swift
//  Gather4
//
//  Created by apple on 15/10/30.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit


class FirstTabVC:JiBaseVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.common_yellow_color
        
        
        let login = UserLoginVC()
        self.addChildViewController(login)
        self.view.addSubview(login.view)
        
    }
}