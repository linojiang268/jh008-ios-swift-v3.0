//
//  CountryPikerVC.swift
//  Jike
//
//  Created by Iosmac on 15/6/9.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import UIKit
import Foundation


protocol CountryPikerDelegate {

    func countrySelected(id:Int, continentId:Int, value:String)
}


class CountryPikerVC: JiBaseVC, UITableViewDataSource, UITableViewDelegate {

    var delegate:CountryPikerDelegate!
    var countryTableView:UITableView!

    let identifier:String = "country_identifier"

    var countryList:NSMutableArray!

    override func viewDidLoad() {
        super.viewDidLoad()


        let titleView = CommonTitleView(vc:self)
        titleView.setTitle("选择国家")
        self.view.addSubview(titleView)

        setBgImg()

        countryList = initCountryData()

        countryTableView  = UITableView(frame: CGRectMake(0, UISettings.common_title_height,
                                                         baseWidth, baseHeight-UISettings.common_title_height))

        self.countryTableView.dataSource = self
        self.countryTableView.delegate = self
        self.countryTableView.showsVerticalScrollIndicator = false
        self.countryTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.countryTableView.separatorColor = Color.common_line_color
        self.countryTableView.backgroundColor = UIColor.clearColor()


        self.view.addSubview(countryTableView)


        
    }

    func initCountryData()-> NSMutableArray {
        let dataBasePath = NSBundle.mainBundle().pathForResource("country_school.db", ofType: nil)!
        let dataBase = FMDatabase(path: dataBasePath)
        let mutArr = NSMutableArray()

        if(dataBase.open()) {
            let rs = dataBase.executeQuery("select * from country order by id asc", withArgumentsInArray: nil)
            while rs.next() {
                let pair = DataIdValuePair()
                pair.id = Int(rs.intForColumn("country_id"))
                pair.value = rs.stringForColumn("chn_name")
                pair.otherId = Int(rs.intForColumn("continent_id"))
                mutArr.addObject(pair)
            }
        }
        dataBase.close()
        return mutArr
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return countryList.count
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        return UISettings.country_city_item_height
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: CountryUniversityCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? CountryUniversityCell
        if (cell == nil) {
            cell = CountryUniversityCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        if (countryList.count > indexPath.row)
        {
            cell!.setData(countryList[indexPath.row] as! DataIdValuePair, cellType:CountryUniversityCell.CellType.Country)
        }
        return cell!
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        UiUtils.closeCurrentVC()
        if(delegate != nil) {
            let country = (countryList[indexPath.row] as! DataIdValuePair)
            delegate.countrySelected(country.id!, continentId:country.otherId!, value: country.value!)
        }
    }

}