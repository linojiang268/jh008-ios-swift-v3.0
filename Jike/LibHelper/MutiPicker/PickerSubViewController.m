//
//  SelectMoreImageSubViewController.m
//  brandyond
//
//  Created by ysq on 14/6/30.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

#import "PickerSubViewController.h"
#import "AssetHelper.h"
#import "ALAsset+Equal.h"

@interface PickerSubViewController ()

@end

@implementation PickerSubViewController{
    NSArray *_imageAssetArray;   //图片对象
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [[ASSETHELPER getGroupInfo:self.group]objectForKey:@"name"];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self configureNavigation];
    if (!self.selectedArray) {
        self.selectedArray = [[NSMutableArray alloc]init];
    }
    
    //设置显示的数字的图片
    [self resetNumberView];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    [self loadImage];
}


-(void)loadImage{
    [ASSETHELPER getAssetWithGroup:self.group result:^(NSArray *arr) {
        _imageAssetArray = arr;
        [self.collectionView reloadData];
    }];
}
/**
 *  配置头部导航
 */
-(void)configureNavigation{
    UIBarButtonItem *close = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = close;
    
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = back;
   
}

-(void)close{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


-(void)back{
    if (self.subFinishSelectBlock) {
        self.subFinishSelectBlock([_selectedArray mutableCopy]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_imageAssetArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    for (UIView *v in cell.contentView.subviews) {
        [v removeFromSuperview];
    }
    
    ALAsset *asset = _imageAssetArray[indexPath.row];
    UIButton *image = [UIButton buttonWithType:UIButtonTypeCustom];
    image.frame = CGRectMake(0, 0, 70, 70);
    image.selected = [self.selectedArray containsObject:asset];
    image.userInteractionEnabled = NO;
    //加载图片
    UIImage *img = [ASSETHELPER getAssetThumbnail:asset];
    [image setBackgroundImage:img forState:UIControlStateNormal];
    [image setBackgroundImage:img forState:UIControlStateSelected];
    [image setImage:[UIImage imageNamed:@"noSelectImage"] forState:UIControlStateNormal];
    [image setImage:[UIImage imageNamed:@"selectImage"] forState:UIControlStateSelected];
    [cell.contentView addSubview:image];

    return cell;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ALAsset *asset = _imageAssetArray[indexPath.row];
    if ([self.selectedArray containsObject:asset]) {
        //包含的时候删除掉
        [self.selectedArray removeObject:asset];
        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }else{
        if ([self.selectedArray count]<self.maxSelectImageCount) {
            //不包含的时候加入进取
            [self.selectedArray addObject:asset];
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }else{
            //超过最大数目
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"最多选择%d张图片",self.maxSelectImageCount] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
    
    //设置显示的数字的图片
    [self resetNumberView];
}

//点击完成
- (IBAction)PressFinishSelect:(id)sender {
    if (self.finishBlock) {
        self.finishBlock([self.selectedArray mutableCopy]);
    }
    [self close];
}


-(void)resetNumberView{
    CGRect frame = self.selectImageNumber.frame;
    int temp = [self.selectedArray count];
    if (temp>=10) {
        frame.size.width = 34;
    }else{
        frame.size.width = 25;
    }
    self.selectImageNumber.frame = frame;
    if (temp>99) {
        temp = 99;
    }

    [self.selectImageNumber setTitle:[NSString stringWithFormat:@"%d",temp] forState:UIControlStateNormal];
    
    self.selectImageNumber.layer.cornerRadius = frame.size.height/2.0;
    self.selectImageNumber.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
