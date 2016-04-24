//
//  RegisterStepOneCell.swift
//  Gather4
//
//  Created by apple on 15/11/4.
//


import Foundation
import UIKit

class RegisterStepOneCell: UICollectionViewCell {
    
    private var iconV:UIButton!
    private var descV:UILabel!
    private var cellData:InterestData!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Color.white
        
        iconV = UIButton(frame:CGRectNull)
        descV = UiUtils.createCommonLabelWithAlign(0, y: frame.height-40, width: frame.width, height: 40, fontSize: UISettings.common_font_size_middle,
                                                   align: NSTextAlignment.Center, title: nil)

        self.addSubview(descV)
        self.addSubview(iconV)
        
        iconV.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self)
        }
        
        self.iconV.contentMode = UIViewContentMode.ScaleAspectFit
        self.iconV.addTarget(self, action: "btnClicked", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func setData(cellData:InterestData) {
        
        self.cellData = cellData
        
        self.backgroundColor = cellData.isSelected ? cellData.bgColor : Color.gray
        
        self.iconV.setImage(UIImage(named: cellData.imgNameNormal!), forState: UIControlState.Normal)
        self.iconV.setImage(UIImage(named: cellData.imgNameSelected!), forState: UIControlState.Selected)
        
        self.descV.text = cellData.interestName
    }

    func btnClicked() {
        self.cellData.isSelected = !self.cellData.isSelected
        self.backgroundColor = self.cellData.isSelected ? self.cellData.bgColor : Color.gray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}