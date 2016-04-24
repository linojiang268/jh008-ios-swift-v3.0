//
//  SelectMoreImageSubViewController.h
//  brandyond
//
//  Created by ysq on 14/6/30.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSQImagePickerViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface PickerSubViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)ALAssetsGroup *group;
@property(nonatomic,strong)NSMutableArray *selectedArray;  //已经选择的图片对象
@property(nonatomic,strong)FinishSelectImageBlock finishBlock;  //保存父类关闭的块调用
@property(nonatomic,strong)void(^subFinishSelectBlock)(NSMutableArray *array);
@property(nonatomic,assign)int maxSelectImageCount;  //最多选择的个数


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *selectImageNumber;


@end
