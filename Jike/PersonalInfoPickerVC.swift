//
//  PersonalInfoPickerVC.swift
//  Jike
//
//  Created by Iosmac on 15/8/9.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import UIKit
import Foundation

protocol PersonalInfoPickerDelegate {

    func personalInfoSelected(personalInfo:String, pageType:PersonalInfoPickerVC.PageType)
}

//获取标签 交友要求等数据的界面
class PersonalInfoPickerVC: JiBaseVC, BaseTitleViewDelegate, UITableViewDataSource, UITableViewDelegate,
                            PickOneStringDelegate{

    enum PageType {
        case MyPoint//我的标签
        case MakeFriendsRequirement//交友要求
        case MyHobby//我的兴趣爱好
    }

    let padding = UISettings.common_table_padding*2

    var tableV:UITableView!

    var delegate:PersonalInfoPickerDelegate!

    var pageType:PageType = PageType.MyPoint

    var initDataList:[String]?

    var dataList:Array<DataIdValuePair> = Array<DataIdValuePair>()

    let identifier = "personal_info_list_cell"
    var footer:FooterView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let titleView = CommonTitleView(vc:self)
        if(pageType == PageType.MyPoint) {
            titleView.setTitle("我的标签")
        }
        else if(pageType == PageType.MakeFriendsRequirement) {
            titleView.setTitle("交友要求")
        }
        else if(pageType == PageType.MyHobby) {
            titleView.setTitle("兴趣爱好")
        }
        titleView.myDelegate = self
        self.view.addSubview(titleView)

        setBgImg()

        tableV = UITableView(frame: CGRectMake(0, UISettings.common_title_height, baseWidth,
                                               baseHeight-UISettings.common_title_height))
        self.tableV.dataSource = self
        self.tableV.delegate = self
        self.tableV.showsVerticalScrollIndicator = false
        self.tableV.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.tableV.separatorColor = Color.common_line_color
        self.tableV.backgroundColor = UIColor.clearColor()

        footer = FooterView(frame: CGRectMake(0, 0, baseWidth, UISettings.personal_info_item_height))
        tableV.tableFooterView = footer
        footer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "footerClicked"))

        self.view.addSubview(tableV)

        self.view.bringSubviewToFront(titleView)

        initData()

    }

    func footerClicked() {
        let vc = PickOneStringVC()
        vc.setPageData(nil, delegate: self, limitChar: 10)
        UiUtils.openOneNewVC(vc)
    }

    private func isDataInInitData(data:String) -> Bool {
        if(initDataList != nil) {
            for s in initDataList! {
                if (data == s) {
                    return true
                }
            }
        }
        return false
    }

    func initData() {
        dataList.removeAll(keepCapacity: false)

        if(pageType == PageType.MyPoint) {
            let myPoint:NSArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("my_point.plist",
                                          ofType: nil)!)!
            for p in myPoint {
                let pair = DataIdValuePair()
                pair.id = isDataInInitData(p as! String) ? 1 : 0
                pair.value = p as? String
                dataList.append(pair)
            }
        }
        else if(pageType == PageType.MakeFriendsRequirement) {
            let make:NSArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("make_friends_requirement.plist",
                                       ofType: nil)!)!
            for p in make {
                let pair = DataIdValuePair()
                pair.id = isDataInInitData(p as! String) ? 1 : 0
                pair.value = p as? String
                dataList.append(pair)
            }
        }
        else if(pageType == PageType.MyHobby) {
            let myHobby:NSArray = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("my_hobby.plist",
                                          ofType: nil)!)!
            for p in myHobby {
                let pair = DataIdValuePair()
                pair.id = isDataInInitData(p as! String) ? 1 : 0
                pair.value = p as? String
                dataList.append(pair)
            }
        }

        putInitdataNotInSourceToTable()

        self.tableV.reloadData()
    }

    //手动添加的属性，在原始列表数据里并不存在，所以当上一级传入这样的数据时，直接加入表格的数据源并设置为选中状态
    func putInitdataNotInSourceToTable() {
        if(initDataList != nil && initDataList?.count > 0) {
            for initItem in initDataList! {

                var isInSource = false

                for soureItem in dataList {
                    if(soureItem.value == initItem) {
                        isInSource = true
                        break
                    }
                }

                if(!isInSource) {
                    let pair = DataIdValuePair()
                    pair.id = 1
                    pair.value = initItem
                    dataList.append(pair)
                }
            }
        }
    }

    func rightOkBtnClick() {

        if(delegate != nil) {
            var res = ""
            for data in dataList {
                if(data.id == 1 && data.value != nil) {
                    res = res + data.value! + " "
                }
            }
            if(res.characters.count>1) {
                res = res.substringToIndex(res.endIndex.advancedBy(-1))
                LogUtils.log("res=\(res), self.pageType=\(self.pageType)")
                delegate.personalInfoSelected(res, pageType:self.pageType)
            }
            else {
                delegate.personalInfoSelected("", pageType:self.pageType)
            }
        }
        UiUtils.closeCurrentVC()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataList.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return UISettings.personal_info_item_height
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: PersonalInfoPickerCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? PersonalInfoPickerCell
        if (cell == nil) {
            cell = PersonalInfoPickerCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }

        cell!.setData(dataList[indexPath.row])

        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        dataList[indexPath.row].id = dataList[indexPath.row].id == 0 ? 1 : 0
        tableView.reloadData()
    }

    func pickOneStringBack(string:String?) {
        if(DataUtils.isStringNotEmpty(string)) {
            let pair = DataIdValuePair()
            pair.id = 1
            pair.value = string!
            dataList.append(pair)
            tableV.reloadData()
        }
    }

    class FooterView:UIView {

        private let padding = UISettings.common_table_padding
        private var title:UILabel!
        private var arrowView:UIImageView!

        override init(frame: CGRect) {
            super.init(frame: frame)

            self.backgroundColor = Color.common_text_bg_color
            self.layer.addSublayer(UiUtils.createDividerLine(padding*3, y: 0, width: frame.width-padding*3))

            self.title = UiUtils.createCommonLabelWithAlign(padding*3, y: padding*2, width: self.frame.width-padding*6,
                                                            fontSize: UISettings.common_label_title_font,
                                                            align: NSTextAlignment.Left, title: "添加")

            self.title.textColor = Color.styleColor

            let arrImg = UIImage(named: "common_arrow_right_icon_img")!
            self.arrowView = UIImageView(frame: CGRectMake(self.frame.width-arrImg.size.width-padding*2,
                                                           0, arrImg.size.width, arrImg.size.height))
            self.arrowView.image = arrImg

            self.title.center.y = self.frame.height/2
            self.arrowView.center.y = self.frame.height/2

            self.addSubview(self.title)
            self.addSubview(self.arrowView)

            self.userInteractionEnabled = true
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }


}
