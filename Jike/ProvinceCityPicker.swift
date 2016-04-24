//
//  ProvinceCityPicker.swift
//  Jike
//
//  Created by Iosmac on 15/6/9.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import UIKit
import Foundation



class ProvinceCityPicker: ParentPicker, ParentPickerDelegate {


    var provinceList:NSMutableArray!
    var cityList:NSMutableArray!

    convenience init(parentVC:UIViewController, existDataCity:Int?) {
        self.init(parentVC: parentVC)

        if(existDataCity != nil && existDataCity! >= 0) {

            let cityData = getCityById(existDataCity!)
            //兼容拿不到对应的城市信息info
            if(cityData.otherId == nil)
            {
                initData(self, selectedRow: 0)
                return
            }
            cityList = getCityArray(cityData.otherId!)
            for index2 in 0...(cityList.count-1) {
                let city = cityList[index2] as! DataIdValuePair
                if(city.id == existDataCity!) {
                    initData(self, selectedRow: index2, componentRow: 1)
                    break
                }
            }

            for index in 0...(provinceList.count-1) {
                let pro = provinceList[index] as! DataIdValuePair
                if(pro.id == cityData.otherId) {
                    initData(self, selectedRow: index)

                    break
                }
            }
        }
        else {
            initData(self, selectedRow: 0)
        }
    }

    override init(parentVC:UIViewController) {
        super.init(parentVC: parentVC)

        provinceList = initProvinceData()
        cityList = getCityArray((provinceList[0] as! DataIdValuePair).id!)

        initData(self, selectedRow: 0)
    }

    func initProvinceData()-> NSMutableArray {
        let dataBasePath = NSBundle.mainBundle().pathForResource("province_city.db", ofType: nil)!
        let dataBase = FMDatabase(path: dataBasePath)
        let mutArr = NSMutableArray()

        if(dataBase.open()) {

            let rs = dataBase.executeQuery("select * from province", withArgumentsInArray: nil)

            while rs.next() {
                let pair = DataIdValuePair()
                pair.id = Int(rs.intForColumn("id"))
                pair.value = rs.stringForColumn("name")

                mutArr.addObject(pair)
            }
        }
        dataBase.close()
        return mutArr
    }

    func getCityArray(provinceId:Int) -> NSMutableArray {
        let dataBasePath = NSBundle.mainBundle().pathForResource("province_city.db", ofType: nil)!
        let dataBase = FMDatabase(path: dataBasePath)
        let mutArr = NSMutableArray()

        if(dataBase.open()) {

            let rs = dataBase.executeQuery("select * from city where province_id=\(provinceId)", withArgumentsInArray: nil)

            while rs.next() {
                let pair = DataIdValuePair()
                pair.id = Int(rs.intForColumn("id"))
                pair.value = rs.stringForColumn("name")

                mutArr.addObject(pair)
            }
        }
        dataBase.close()
        return mutArr
    }

    func getCityById(cityId:Int) -> DataIdValuePair {
        let dataBasePath = NSBundle.mainBundle().pathForResource("province_city.db", ofType: nil)!
        let dataBase = FMDatabase(path: dataBasePath)
        let pair = DataIdValuePair()

        if(dataBase.open()) {
            let rs = dataBase.executeQuery("select * from city where id=\(cityId)", withArgumentsInArray: nil)

            while rs.next() {
                pair.id = Int(rs.intForColumn("id"))
                pair.value = rs.stringForColumn("name")
                pair.otherId = Int(rs.intForColumn("province_id"))
            }
        }
        dataBase.close()
        return pair
    }

    func getTitleForShow(index:Int, component:Int)-> String {

        if(index > provinceList.count-1)
        {
            return ""
        }
        let proviceName = (provinceList[index] as! DataIdValuePair).value

        if(component == 0) {
            return proviceName!
        }
        else {
            return (self.cityList[index] as! DataIdValuePair).value!
        }
    }

    func getNumOfComponent() -> Int {
        return 2
    }

    func getRowForComponent(component:Int) -> Int {
        LogUtils.log("getRowForComponent()\(component)")
        if(component == 0) {
            return provinceList.count
        }else {
            let proviceId = (provinceList[picker.selectedRowInComponent(0)] as! DataIdValuePair).id!
            self.cityList = getCityArray(proviceId)
            return cityList.count
        }
    }

    func selctedRow(index1:Int, index2:Int) {
        LogUtils.log("selctedRow():index1=\(index1), index2=\(index2)")
        let province = provinceList[index1] as! DataIdValuePair
        let city = cityList[index2] as! DataIdValuePair
        if(dataPickedDelegate != nil) {
            dataPickedDelegate.selectedData(province.id!, value1: province.value!, id2: city.id!, value2: city.value!)
        }
    }



    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}