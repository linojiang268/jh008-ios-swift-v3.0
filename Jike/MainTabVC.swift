//
//  MainVC.swift
//  Gather4
//
//  Created by apple on 15/10/29.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit


class MainTabVC: UITabBarController, LocationControllDelegate, UITabBarControllerDelegate {
    
    var firstVC = FirstTabVC()
    var activityVC = ActivityTabVC()
    var leagueVC = LeagueTabVC()
    
    var locaitonCtrl:LocationController!

    var currentSelectedIndex:Int = -1
    //用于防止反复定位
    var tmpHadLocation:Bool = false
    //用于防止重复点击
    var tmpRepect:Bool = false
    
    let chatDelegateKeyInMainTabVC = "chatDelegateKeyMainTabVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //定位
        locaitonCtrl = LocationController(locBack: { (address) -> Void in
            let theAddress:String? = address as String
            if(theAddress != nil )
            {
                if(!theAddress!.isEmpty)
                {
                    
                }
            }
        })
        self.delegate = self
        locaitonCtrl.locateDelegate = self
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = Color.common_black_bg //UIColor(patternImage: UIImage(named: "app_bg_img")!)
        

        self.setViewControllers([firstVC, activityVC, leagueVC], animated: true)
        
        self.tabBar.backgroundImage = UIImage(named: "tab_bar_bg")
        
        self.tabBar.contentMode = UIViewContentMode.Center
        
        
        let tabBar1 = UITabBarItem(title: "",
            image: UIImage(named: "MainTabFirstBtn")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal),
            selectedImage: UIImage(named: "MainTabFirstBtn")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        
        let tabBar2 = UITabBarItem(title: "",
            image: UIImage(named: "MainTabFirstBtn")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal),
            selectedImage: UIImage(named: "MainTabFirstBtn")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))
        
        let tabBar3 = UITabBarItem(title: "",
            image: UIImage(named: "MainTabFirstBtn")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal),
            selectedImage: UIImage(named: "MainTabFirstBtn")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))

        
        let padding:CGFloat = 6
        
        tabBar1.imageInsets = UIEdgeInsets(top: padding, left: 0, bottom: -padding, right: 0)
        tabBar2.imageInsets = UIEdgeInsets(top: padding, left: 0, bottom: -padding, right: 0)
        tabBar3.imageInsets = UIEdgeInsets(top: padding, left: 0, bottom: -padding, right: 0)
        
        firstVC.tabBarItem = tabBar1
        activityVC.tabBarItem = tabBar2
        leagueVC.tabBarItem = tabBar3
        
        self.tabBar.hidden = false
        
        self.selectedIndex = 0
        
    }
    
    //双击刷新
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController)
    {
        
        if (self.currentSelectedIndex < 0 )
        {
            self.currentSelectedIndex = tabBarController.selectedIndex
        }
        else
        {

            self.reloadAction()
            self.currentSelectedIndex = tabBarController.selectedIndex
        }
    }
    
    //延迟防止按钮重复点击请求
    func solveDoubleClicked()
    {
        self.tmpRepect = false
    }
    
    func reloadAction()
    {

    }
    
    //定位完成
    func locateFinished(lat:Double,lon:Double) {
        
    }
    //定位失败
    func loacteFaild() {
        
    }

}