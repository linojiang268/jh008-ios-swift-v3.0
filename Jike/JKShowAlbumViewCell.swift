//
//  JKShowAlbumViewCell.swift
//  Jike
//
//  Created by jsonmess on 15/9/15.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import UIKit

class JKShowAlbumViewCell: UICollectionViewCell {
    
    var imageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.imageView = UIImageView(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        self.imageView.clipsToBounds = true
        self.contentView.addSubview(self.imageView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(imageStr:String?)
    {
        if(imageStr != nil)
        {
            self.imageView.sd_setImageWithURL(
                NSURL(string:DataUtils.getUTF8String(imageStr!+DataSettings.thumb_pic_url_follow_in_mine)),
                placeholderImage: UIImage(named:"common_head_icon_default_img"),
                options: SDWebImageOptions.RetryFailed & SDWebImageOptions.LowPriority)
        }
        else
        {
            self.imageView.image = UIImage(named:"common_head_icon_default_img")
        }
    }
    
}
