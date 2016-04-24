//
//  RegisterStepOneVC.swift
//  Gather4
//
//  Created by apple on 15/11/3.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation
import UIKit

class RegisterStepOneVC: JiBaseVC, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var collectionView:UICollectionView!
    private var interestDataList:[InterestData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBgImg()
        
        let titleV = UserSysBackTitleView(vc: self)
        titleV.setTitle("注册")
        
        let tipsV = CommonLabelView(x: UISettings.common_padding, y: titleV.frame.maxY+UISettings.common_padding,
                                    width:UiUtils.getBaseWidth()-UISettings.common_padding*2,
                                    text: "请选择您的感兴趣的项，我们会帮助您发现有意思的活动")
        
        collectionView = UICollectionView(frame: CGRectNull, collectionViewLayout:UICollectionViewFlowLayout())
        
        let nextStepBtn = CommonButton(x: UISettings.common_padding,
                                       y: UiUtils.getBaseHeight()-UISettings.common_button_view_height-UISettings.common_padding,
                                       width: UiUtils.getBaseWidth()-UISettings.common_padding*2, title: "下一步")
        
        self.view.addSubview(tipsV)
        self.view.addSubview(titleV)
        self.view.addSubview(collectionView)
        self.view.addSubview(nextStepBtn)
        
        collectionView.backgroundColor = Color.none
        collectionView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view).offset(EdgeInsets(top: tipsV.frame.maxY+UISettings.common_padding, left: 0,
                                                            bottom: -nextStepBtn.frame.height-UISettings.common_padding, right: 0))
        }
        collectionView.registerClass(RegisterStepOneCell.classForCoder(), forCellWithReuseIdentifier: "interestCell")
        
        nextStepBtn.addTarget(self, action: "gotoNextStepClicked", forControlEvents: UIControlEvents.TouchUpInside)
        
        initData()
    }
    
    func initData() {
        interestDataList = RegisterController().getInterestData()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func getSelectedDataList() -> Array<InterestData> {
        var tempSelected = Array<InterestData>()
        for item in interestDataList {
            if(item.isSelected) {
                tempSelected.append(item)
            }
        }
        return tempSelected
    }
    
    func gotoNextStepClicked() {
        let list = getSelectedDataList()
        UiUtils.openOneNewVC(RegisterStepTwoVC())
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("interestCell", forIndexPath: indexPath) as! RegisterStepOneCell
        
        cell.setData(interestDataList[indexPath.section*2+indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        LogUtils.log("didSelectItemAtIndexPath:indexPath=\(indexPath.row), \(indexPath.section)")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return interestDataList.count/2
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = (UiUtils.getBaseWidth()-UISettings.common_padding*3)/2
        
        return CGSize(width: width, height: width*0.8)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: UISettings.common_padding, bottom: UISettings.common_padding, right: UISettings.common_padding)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
}
