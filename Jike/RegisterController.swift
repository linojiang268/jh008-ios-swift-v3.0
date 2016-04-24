//
//  RegisterController.swift
//  Gather4
//
//  Created by apple on 15/11/4.
//  Copyright © 2015年 ios. All rights reserved.
//

import Foundation


class RegisterController: BaseController {
    
    
    func getInterestData() -> [InterestData] {
        
        var interestArr = Array<InterestData>()
        interestArr.append(InterestData(interestName: "运动户外", imgNameNormal: "interest_exercise_outdoors",
                                        imgNameSelected:"interest_exercise_outdoorsSelected", bgColor: Color.interest_color_red))
        
        interestArr.append(InterestData(interestName: "文化艺术", imgNameNormal: "interest_culture_art",
                                        imgNameSelected:"interest_culture_artSelected", bgColor: Color.interest_color_yellow))
        
        interestArr.append(InterestData(interestName: "摄影旅行", imgNameNormal: "interest_photography_travel",
                                        imgNameSelected:"interest_photography_travelSelected", bgColor: Color.interest_color_green))
        
        interestArr.append(InterestData(interestName: "音乐舞蹈", imgNameNormal: "interest_music_dance",
                                        imgNameSelected:"interest_music_danceSelected", bgColor: Color.interest_color_blue))
        
        interestArr.append(InterestData(interestName: "时尚生活", imgNameNormal: "interest_life",
                                        imgNameSelected:"interest_lifeSelected", bgColor: Color.interest_color_black))
        
        interestArr.append(InterestData(interestName: "读书写作", imgNameNormal: "interest_reading_writing",
                                        imgNameSelected:"interest_reading_writingSelected", bgColor: Color.interest_color_red))
        
        interestArr.append(InterestData(interestName: "美食", imgNameNormal: "interest_food",
                                        imgNameSelected:"interest_foodSelected", bgColor: Color.interest_color_yellow))
        
        interestArr.append(InterestData(interestName: "汽车", imgNameNormal: "interest_car",
                                        imgNameSelected:"interest_carSelected", bgColor: Color.interest_color_green))
        
        interestArr.append(InterestData(interestName: "创业", imgNameNormal: "interest_entrepreneurship",
                                        imgNameSelected:"interest_entrepreneurshipSelected", bgColor: Color.interest_color_blue))
        
        interestArr.append(InterestData(interestName: "公益", imgNameNormal: "interest_public_welfare",
                                        imgNameSelected:"interest_public_welfareSelected", bgColor: Color.interest_color_black))
        
        interestArr.append(InterestData(interestName: "亲子", imgNameNormal: "interest_parents_children",
                                        imgNameSelected:"interest_parents_childrenSelected", bgColor: Color.interest_color_red))
        
        interestArr.append(InterestData(interestName: "其他", imgNameNormal: "interest_other",
                                        imgNameSelected:"interest_otherSelected", bgColor: Color.interest_color_yellow))
        
        
        return interestArr as [InterestData]
    }
    
    
    
}