//
//  LoginData.swift
//  Gather4
//
//  Created by apple on 15/11/9.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation


class LoginData : DataParent, Mappable {
    
    var mobile:String?
    var nick_name:String?
    var gender:Int?
    var tag_ids:[Int]?
    var birthday:String?
    var user_id:Int?
    var push_alias:String?
    var is_team_owner:Bool?
    var avatar_url:String?
    
    override init() {
        super.init()
    }
    
    required override init?(_ map: Map) {
        super.init(map)
        mapping(map)
    }
    
    func mapping(map: Map) {
        mobile     <- map["mobile"]
        nick_name     <- map["nick_name"]
        gender     <- map["gender"]
        tag_ids     <- map["tag_ids"]
        birthday     <- map["birthday"]
        user_id     <- map["user_id"]
        push_alias     <- map["push_alias"]
        is_team_owner     <- map["is_team_owner"]
        avatar_url     <- map["avatar_url"]
    }
    
}
