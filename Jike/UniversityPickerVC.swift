//
//  UniversityPickerVC.swift
//  Jike
//
//  Created by Iosmac on 15/6/9.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import UIKit
import Foundation

protocol UniversityPikerDelegate {

    func universitySelected(id:Int, valueEN:String, valueCN:String)
}


class UniversityPikerVC: JiBaseVC, UITableViewDataSource, UITableViewDelegate {

    var delegate:UniversityPikerDelegate!
    var universityTableView:UITableView!

    let identifier:String = "university_identifier"

    var countryId:Int!

    var universityList:NSMutableArray!
    var universityListForShow = NSMutableArray()
    //用于保存在本地数据库中查询的数据
    var tmpUniversityList = NSMutableArray()
    
    let fieldHeight:CGFloat = UISettings.user_page_field_height
    let padding = UISettings.common_table_padding
    var countryInput: UITextField!
    
    var theFootView:JKUniversityFootView!
    //是否是注册时候调用
    var isFromRegister:Bool = false
    
    var customAddVC:JKUniversityCustomAdd!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleView = CommonTitleView(vc:self)
        titleView.setTitle("选择大学")
        titleView.showLeftBackBtnOnly()
        self.view.addSubview(titleView)

        setBgImg()

        universityList = getUniversityArray(self.countryId)
        for obj in universityList {
            universityListForShow.addObject(obj)
        }

        countryInput = UiUtils.createUserTextField(CGRectMake(padding, UISettings.common_title_height+padding,
                                                    baseWidth-padding*2, fieldHeight),
                                                    leftImg: UIImage(named: "register_search_university_icon")!,
                                                    holder: "搜索大学", keyBoardType: UIKeyboardType.Default)

        universityTableView  = UITableView(frame: CGRectMake(0, countryInput.frame.maxY+padding,
                                                             baseWidth, baseHeight-UISettings.common_title_height))

        universityTableView.tableFooterView = UIView(frame: CGRectMake(0, 0, 0, UISettings.common_key_board_height+80))

        self.universityTableView.dataSource = self
        self.universityTableView.delegate = self
        self.universityTableView.showsVerticalScrollIndicator = false
        self.universityTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.universityTableView.separatorColor = Color.common_line_color
        self.universityTableView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(countryInput)
        self.view.addSubview(universityTableView)
        countryInput.addTarget(self, action: "universityInputChanged", forControlEvents: UIControlEvents.EditingChanged)

        self.view.bringSubviewToFront(titleView)
        titleView.userInteractionEnabled = true
        titleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "titleClicked"))
        
        //FootView
        self.theFootView = JKUniversityFootView(frame: CGRectMake(0, 0, baseWidth, UISettings.country_city_item_height))
        self.theFootView.addTarget(self, action: "showMoreUniversitiesAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.universityTableView.tableFooterView = self.theFootView
        if (self.isFromRegister)
        {
            self.theFootView.showTheUniversityFootView()
        }
        //默认状态
        self.theFootView.theStatus = kUniversityLoadStatus.universityLoadMore
        self.universityTableView.contentInset = UIEdgeInsetsMake(0,0, UISettings.country_city_item_height+20.0,0)
        self.universityTableView.tableFooterView?.frame = CGRectMake(0, 0, baseWidth, UISettings.country_city_item_height)
    }

    func titleClicked() {
        countryInput.resignFirstResponder()
    }

    func universityInputChanged() {
        universityListForShow.removeAllObjects()
        self.theFootView.theStatus = kUniversityLoadStatus.universityLoadMore
        if(countryInput.text != nil && (countryInput.text!).characters.count>0) {
            for c in universityList {
                let pair = c as! DataIdValuePair
                if((pair.value?.lowercaseString.rangeOfString(countryInput.text!.lowercaseString) != nil) ||
                   (pair.otherValue?.lowercaseString.rangeOfString(countryInput.text!.lowercaseString) != nil)) {

                    LogUtils.log("countryInput:\(pair.value!.lowercaseString), \(countryInput.text!.lowercaseString)")
                    self.universityListForShow.addObject(pair)
                }
            }
            self.tmpUniversityList = NSMutableArray(array: self.universityListForShow)
        }
        else {
            self.universityListForShow = NSMutableArray(array: self.universityList)
        }
        self.universityTableView.reloadData()
    }

    func getUniversityArray(countryId:Int) -> NSMutableArray {
        LogUtils.log("getUniversityArray():countryId=\(countryId)")
        let libPath:String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory,
            NSSearchPathDomainMask.UserDomainMask, true)[0]
        let  dbLibPath = NSURL(string: libPath)?.URLByAppendingPathComponent("country_school.db")
        let dataBase = FMDatabase(path: dbLibPath?.absoluteString)
        let mutArr = NSMutableArray()

        if(dataBase.open()) {
            let rs = dataBase.executeQuery("select * from university where country_id=\(countryId)", withArgumentsInArray: nil)
            while rs.next() {
                let pair = DataIdValuePair()
                pair.id = Int(rs.intForColumn("id"))
                pair.value = rs.stringForColumn("name")
                pair.otherValue = rs.stringForColumn("chn_name")
                mutArr.addObject(pair)
            }
        }
        dataBase.close()
        return mutArr
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universityListForShow.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UISettings.country_city_item_height
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: CountryUniversityCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? CountryUniversityCell
        if (cell == nil) {
            cell = CountryUniversityCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        if (universityListForShow.count > indexPath.row)
        {
            cell!.setData(universityListForShow[indexPath.row] as! DataIdValuePair,
                      cellType:CountryUniversityCell.CellType.University)
        }
        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let university = (universityListForShow[indexPath.row] as! DataIdValuePair)
        if(delegate != nil) {
            delegate.universitySelected(university.id!, valueEN: university.value!, valueCN:university.otherValue!)
        }
        
       if (self.recognizeUserChoose(university.id!))
       {
         //写入本地数据库
        let libPath:String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.LibraryDirectory,
            NSSearchPathDomainMask.UserDomainMask, true)[0] 
        let dbLibPath = NSURL(string:libPath)?.URLByAppendingPathComponent("country_school.db").absoluteString
        let dataBase = FMDatabase(path: dbLibPath)
        dataBase.open()
        dataBase.executeUpdate("INSERT INTO university(id,country_id,name,chn_name) VALUES (\(university.id),\(university.otherId),\(university.value),\(university.otherValue))", withArgumentsInArray: nil)
        dataBase.close()
       }
        UiUtils.closeCurrentVC()
    }
    /**
    点击footView 的操作
    - parameter theStatus:
    */
    func showMoreUniversitiesAction()
    {
      //判断状态---更多
        self.countryInput.resignFirstResponder()
        if (self.theFootView.theStatus == kUniversityLoadStatus.universityLoadMore)
        {
            //网络端请求新的学校数据
            self.theFootView.theStatus = kUniversityLoadStatus.universityCustomAdd
            self.searchUniversitiesFromServer()
        }
        else
        {
          UiUtils.openOneNewVC(self.customAddVC)
          self.theFootView.theStatus = kUniversityLoadStatus.universityLoadMore
        }
    }
    /**
     查询服务器
    */
   func searchUniversitiesFromServer()
   {
    let userData = CachedData.getUserLoginedInfoCached()
    let p:HttpParams = HttpParams(isDogParam: true)
    p.addParam("curUid", value: userData!.userId!)
    p.addParam("accountId", value: userData!.accountId!)
    p.addParam("keyword", value:countryInput.text!)
//    DataUniviersity
    ReqServer().requestServer("/location/school/list", params: p, dataBack:{[weak self](data:AnyObject)->Void in
          let res:DataUniviersity = Mapper<DataUniviersity>().map(data as! String)!
         if (res.isSuc())
         {
          //将其取出来
            let universities = res.data
            if(universities != nil)
            {
                for theUniverstiy in universities!
                {
                  let pair = DataIdValuePair()
                    pair.id = theUniverstiy.id
                    pair.value = theUniverstiy.name
                    pair.otherValue = theUniverstiy.chnName
                    pair.otherId = theUniverstiy.countryId
                    //添加到数据数组中
                    self!.universityListForShow.addObject(pair)
                    self!.universityList.addObject(pair)
                }
            }
            //刷新下数据
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self!.universityTableView.reloadData()
            })
        }
    })
   }
    //识别用户选中的学校是否是来自于网络
    func recognizeUserChoose(choseId:Int) ->Bool
    {
        if (self.tmpUniversityList.count <= 0 )
        {
            return true
        }
        else
        {
            var theValue:Bool = false
            for tmpUniversity in tmpUniversityList
            {
                let tmp = tmpUniversity as! DataIdValuePair
                if (tmp.id == choseId)
                {
                    theValue =  true
                }
            }
            return theValue
        }
        
    }
    //MARK:ScrollViewDelegate
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.countryInput.resignFirstResponder()
    }
}