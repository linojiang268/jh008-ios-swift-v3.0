//
//  JKShowUserAlbumsView.swift
//  Jike
//
//  Created by jsonmess on 15/9/14.
//  Copyright (c) 2015年 ios. All rights reserved.
//

import UIKit
class JKShowUserAlbumsView: UIView,UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    let rowCount:Int = 3 //3个/每行
   var collectionView:UICollectionView!//展示用户图片
    var photos:Array<DataMyNTYPhoto>!
    var photosUrl:Array<String>!
    override init(frame: CGRect)
    {
       super.init(frame: frame)
       self.initViews()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews()
    {
        var flowLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = Color.common_page_bg_color
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.addSubview(self.collectionView)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        flowLayout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 5.0, 0.0)
        var width = (DMDeviceManager.getCurrentScreenSize().width-CGFloat(rowCount - 1)*5.0) / CGFloat(rowCount)
        flowLayout.itemSize = CGSizeMake(width, width)
        flowLayout.minimumLineSpacing = 5.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.collectionView.registerClass(JKShowAlbumViewCell.self, forCellWithReuseIdentifier: "userAlbumsStr")
    }
    //数据源
    func setSource(array:Array<DataMyNTYPhoto>,photoUrl:Array<String>)
    {
        //设置array
        self.photos = array
        self.photosUrl = photoUrl
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.collectionView.reloadData()
            
        })
    }
    //MARK:UICollectionViewDelegate 代理
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.photosUrl != nil)
        {
            return self.photosUrl.count
        }
        else
        {
            return 1
        }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath)
        -> UICollectionViewCell {
        var cell:JKShowAlbumViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("userAlbumsStr",
            forIndexPath: indexPath) as! JKShowAlbumViewCell
            if (self.photosUrl != nil)
            {
                var urlStr = self.photosUrl[indexPath.row]
                cell.setContent(urlStr)
            }
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var width = (DMDeviceManager.getCurrentScreenSize().width-CGFloat(rowCount - 1)*5.0) / CGFloat(rowCount)
        //10，为数量，2为间距
        return CGSizeMake(width, width)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //进入浏览大图
        
    }

    

}
