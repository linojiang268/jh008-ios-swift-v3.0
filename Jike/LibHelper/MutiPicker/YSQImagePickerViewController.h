//
//  YSQImagePickerViewController.h
//  Demo
//
//  Created by ysq on 14/7/1.
//  Copyright (c) 2014年 ysq. All rights reserved.
//


#import <UIKit/UIKit.h>

static const int DEFAULTMAXSELECTIMAGECOUNT = 9;  //默认最多选择的个数

typedef void(^FinishSelectImageBlock)(NSMutableArray *array);  //带有选择之后的图片

@interface YSQImagePickerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)FinishSelectImageBlock finishBlock;

@property(nonatomic,strong)NSMutableArray *selectedImageArray;  //保存已经选择的图片对象  AssetImageObject class

@property(nonatomic,assign)int maxSelectImageCount;

@end