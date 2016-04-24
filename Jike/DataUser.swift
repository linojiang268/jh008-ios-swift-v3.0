//
//  DataUser.swift
//  Jike
//
//  Created by Iosmac on 15/6/3.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import Foundation

class DataUser:NSObject, Mappable {

    var userId:Int?
    var accountId:String?
    var uniqueId:String?

    var token:String?

    var userName:String?
    var userHeadIconUrl:String?
    var gender:Int?
    var continentId:Int?
    var countryId:Int?
    var countryName:String?
    var schoolId:Int?
    var schoolName:String?
    var age:Int?

    var otherLoginTypeUserId:String?

    var loginType:Int?

    override init() {

    }

    required init?(_ map: Map) {
        super.init()
        mapping(map)
    }

    func mapping(map: Map) {
        userId     <- map["userId"]
        accountId     <- map["accountId"]
        uniqueId     <- map["uniqueId"]
        token     <- map["token"]
        userName     <- map["userName"]
        gender    <- map["gender"]
        continentId    <- map["continentId"]
        countryId    <- map["countryId"]
        countryName     <- map["countryName"]
        schoolId    <- map["schoolId"]
        schoolName     <- map["schoolName"]
        age     <- map["age"]
        userHeadIconUrl     <- map["userHeadIconUrl"]
        otherLoginTypeUserId     <- map["otherLoginTypeUserId"]
        loginType     <- map["loginType"]
    }
}